//
//  CreatePetViewController.swift
//  Veterinerim
//
//  Created by Emir Alkal on 12.02.2023.
//

import Lottie
import SnapKit
import UIKit

final class CreatePetViewController: UIViewController {
  private var pawAnimation: LottieAnimationView = {
    let lottie = LottieAnimationView()
    lottie.loopMode = .loop
    lottie.animationSpeed = 1
    lottie.contentMode = .scaleAspectFit
    return lottie
  }()
  
  private var animationView: LottieAnimationView = {
    let lottie = LottieAnimationView()
    lottie.loopMode = .loop
    lottie.animationSpeed = 1
    lottie.contentMode = .scaleAspectFit
    return lottie
  }()
  
  private let titleLabel = CustomLabel(text: "Evcil Hayvanini Ekleyelim!", alignment: .left, textColor: Colors.secondary, font: .init(name: "Avenir", size: 60)!, minimumScale: 0.4)
  
  private let dogActionButton = CustomButton(title: "Köpeğim Var!", cornerRadius: 12)
  private let catActionButton = CustomButton(title: "Kedim Var!", cornerRadius: 12)
  private let noneButton = CustomButton(title: "Evcil Hayvanım Yok!", cornerRadius: 12)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Colors.primary
    setupLayout()
    setupLottie(on: animationView, with: "add-pet")
    setupLottie(on: pawAnimation, with: "paw")
  }
  
  private func setupLottie(on lottie: LottieAnimationView, with name: String) {
    lottie.animation = .named(name)
    lottie.play()
  }
  
  private func setupLayout() {
    view.addSubviews(animationView, titleLabel, dogActionButton, catActionButton, noneButton, pawAnimation)
  
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-96)
      make.bottom.equalTo(view.snp.centerY)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
    }
    
    dogActionButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(55)
      make.top.equalTo(view.snp.centerY).offset(24)
    }
    
    catActionButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(55)
      make.top.equalTo(dogActionButton.snp.bottom).offset(12)
    }
    
    noneButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(55)
      make.top.equalTo(catActionButton.snp.bottom).offset(12)
    }
    
    animationView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(72)
      make.trailing.equalToSuperview()
      make.bottom.equalToSuperview().offset(36)
      make.height.equalTo(animationView.snp.width)
    }
    pawAnimation.transform = .init(rotationAngle: -45)
    pawAnimation.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(40)
      make.leading.equalTo(view.snp.centerX).offset(-40)
      make.height.equalTo(pawAnimation.snp.width)
    }
  }
}
