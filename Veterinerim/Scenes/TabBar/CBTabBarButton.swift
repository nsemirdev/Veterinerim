//
//  CBTabBarButton.swift
//  BubbleTabBar
//
//  Created by Anton Skopin on 28/11/2018.
//  Copyright © 2018 cuberto. All rights reserved.
//

import SnapKit
import UIKit

public class CBTabBarItem: UITabBarItem {
  public var tintColor: UIColor?
}

public class CBTabBarButton: UIControl {
  private var _isSelected: Bool = false

  init(item: UITabBarItem) {
    super.init(frame: .zero)
    tabImage = UIImageView(image: item.image)
    defer {
      self.item = item
      configureSubviews()
    }
  }

  private var currentImage: UIImage? {
    var maybeImage: UIImage?
    if _isSelected {
      maybeImage = item?.selectedImage ?? item?.image
    } else {
      maybeImage = item?.image
    }
    guard let image = maybeImage else {
      return nil
    }
    return image.renderingMode == .automatic ? image.withRenderingMode(.alwaysTemplate) : image
  }

  public var item: UITabBarItem? {
    didSet {
      tabImage.image = currentImage
      tabLabel.text = item?.title
      if let tabItem = item as? CBTabBarItem {
        if let color = tabItem.tintColor {
          tintColor = color
        }
      }
    }
  }

  override public var tintColor: UIColor! {
    didSet {
      if _isSelected {
        tabImage.tintColor = tintColor
      }
      tabLabel.textColor = tintColor
      tabBg.backgroundColor = tintColor.withAlphaComponent(0.2)
    }
  }

  private var tabImage = UIImageView()
  private var tabLabel = UILabel()
  private var tabBg = UIView()

  private let bgHeight: CGFloat = 42.0
  private var csFoldedBgTrailing: NSLayoutConstraint!
  private var csUnfoldedBgTrailing: NSLayoutConstraint!
  private var csFoldedLblLeading: NSLayoutConstraint!
  private var csUnfoldedLblLeading: NSLayoutConstraint!

  private var foldedConstraints: [NSLayoutConstraint] {
    return [csFoldedLblLeading, csFoldedBgTrailing]
  }

  private var unfoldedConstraints: [NSLayoutConstraint] {
    return [csUnfoldedLblLeading, csUnfoldedBgTrailing]
  }

  private func layout() {
    addSubview(tabBg)
    addSubview(tabLabel)
    addSubview(tabImage)

    NSLayoutConstraint.activate([
      tabBg.leadingAnchor.constraint(equalTo: leadingAnchor),
      tabBg.centerYAnchor.constraint(equalTo: centerYAnchor),
      tabBg.trailingAnchor.constraint(equalTo: trailingAnchor),
      tabBg.heightAnchor.constraint(equalToConstant: bgHeight),

      tabImage.leadingAnchor.constraint(equalTo: tabBg.leadingAnchor, constant: bgHeight/2),
      tabImage.centerYAnchor.constraint(equalTo: tabBg.centerYAnchor),
      tabLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])

    csFoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
    csUnfoldedLblLeading = tabLabel.leadingAnchor.constraint(equalTo: tabImage.trailingAnchor, constant: bgHeight/4.0)
    csFoldedBgTrailing = tabImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bgHeight/2.0)
    csUnfoldedBgTrailing = tabLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -bgHeight/2.0)
  }

  private func configureSubviews() {
    tabImage.contentMode = .center
    tabImage.translatesAutoresizingMaskIntoConstraints = false
    tabLabel.translatesAutoresizingMaskIntoConstraints = false
    tabLabel.font = UIFont.systemFont(ofSize: 14)
    tabLabel.adjustsFontSizeToFitWidth = true
    tabBg.translatesAutoresizingMaskIntoConstraints = false
    tabBg.isUserInteractionEnabled = false
//    tabImage.setContentHuggingPriority(.required, for: .horizontal)
//    tabImage.setContentHuggingPriority(.required, for: .vertical)
//    tabImage.setContentCompressionResistancePriority(.required, for: .horizontal)
//    tabImage.setContentCompressionResistancePriority(.required, for: .vertical)

    layout()
    fold()
    setNeedsLayout()
  }

  private func fold(animationDuration duration: Double = 0.0) {
    unfoldedConstraints.forEach { $0.isActive = false }
    foldedConstraints.forEach { $0.isActive = true }
    UIView.animate(withDuration: duration) {
      self.tabBg.alpha = 0.0
    }
    UIView.animate(withDuration: duration * 0.4) {
      self.tabLabel.alpha = 0.0
    }
    UIView.transition(with: tabImage, duration: duration, options: [.transitionCrossDissolve]) {
      self.tabImage.tintColor = .black
    }
  }

  private func unfold(animationDuration duration: Double = 0.0) {
    foldedConstraints.forEach { $0.isActive = false }
    unfoldedConstraints.forEach { $0.isActive = true }
    UIView.animate(withDuration: duration) {
      self.tabBg.alpha = 1
    }
    UIView.animate(withDuration: duration * 0.5, delay: duration * 0.5, options: [], animations: {
      self.tabLabel.alpha = 1.0
    }, completion: nil)
    UIView.transition(with: tabImage, duration: duration, options: [.transitionCrossDissolve], animations: {
      self.tabImage.tintColor = self.tintColor
    })
  }

  public func setSelected(_ selected: Bool, animationDuration duration: Double = 0.0) {
    _isSelected = selected
    UIView.transition(with: tabImage, duration: 0.05, options: [.beginFromCurrentState]) {
      self.tabImage.image = self.currentImage
    }
    if selected {
      unfold(animationDuration: duration)
    } else {
      fold(animationDuration: duration)
    }
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    tabBg.layer.cornerRadius = tabBg.bounds.height/2.0
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
