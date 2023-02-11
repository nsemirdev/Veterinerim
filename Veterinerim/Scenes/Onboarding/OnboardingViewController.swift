//
//  ViewController.swift
//  Veterinerim
//
//  Created by Emir Alkal on 11.02.2023.
//

import Lottie
import SnapKit
import UIKit

final class OnboardingViewController: UIViewController {
  var viewModel = OnboardingPresentationViewModel()
  var presentation: OnboardingPresentation? {
    didSet {
      guard let presentation else {
        navigateToMainScene()
        return
      }
      infoLabel.text = presentation.text
      pageControl.currentPage = presentation.index
      setupLottie(with: presentation.lottieName)
      presentation.index == 2 ? actionButton.setTitle("Haydi Başlayalım!", for: .normal) : ()
    }
  }

  private let actionButton = CustomButton(title: "Devam Et", cornerRadius: 12)

  private var animationView: LottieAnimationView = {
    let lottie = LottieAnimationView()
    lottie.loopMode = .loop
    lottie.animationSpeed = 1
    lottie.contentMode = .scaleAspectFit
    return lottie
  }()
  
  private let skipButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Atla", for: .normal)
    button.setTitleColor(Colors.secondary, for: .normal)
    button.titleLabel?.font = .init(name: "Avenir", size: 18)
    return button
  }()
  
  private let pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.numberOfPages = 3
    pageControl.currentPageIndicatorTintColor = Colors.secondary
    pageControl.pageIndicatorTintColor = Colors.ternary
    return pageControl
  }()
  
  private let infoLabel = CustomLabel(text: "", alignment: .center)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presentation = viewModel.start()
    setupLayout()
    setupActions()
    view.backgroundColor = Colors.primary
  }
  
  private func setupActions() {
    actionButton.addTarget(self, action: #selector(onNextClick), for: .touchUpInside)
    skipButton.addTarget(self, action: #selector(onSkipClick), for: .touchUpInside)
  }

  @objc private func onNextClick() {
    presentation = viewModel.click()
  }
  
  @objc private func onSkipClick() {
    navigateToMainScene()
  }
  
  private func navigateToMainScene() {
    print("navigate")
  }
  
  private func setupLottie(with name: String) {
    animationView.animation = .named(name)
    animationView.play()
  }
  
  private func setupLayout() {
    let padding: CGFloat = 24
    view.addSubviews(animationView, actionButton, skipButton, pageControl, infoLabel)
    
    animationView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(padding * 3)
      make.trailing.equalToSuperview().offset(-padding * 3)
      make.height.equalTo(animationView.snp.width)
      make.centerY.equalToSuperview().offset(-padding * 3)
    }
    
    actionButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-padding)
      make.height.equalTo(55)
    }
    
    skipButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-padding)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(padding)
    }
    
    pageControl.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(actionButton.snp.top).offset(-16)
    }
    
    infoLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(padding)
      make.trailing.equalToSuperview().offset(-padding)
      make.top.equalTo(animationView.snp.bottom).offset(8)
      make.bottom.equalTo(pageControl.snp.top).offset(-8)
    }
  }
}
