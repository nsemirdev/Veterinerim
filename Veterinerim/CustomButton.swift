//
//  CustomButton.swift
//  Veterinerim
//
//  Created by Emir Alkal on 11.02.2023.
//

import UIKit

final class CustomButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    setTitleColor(Colors.ternary, for: .disabled)
    setTitleColor(Colors.quaternary, for: .normal)
    backgroundColor = Colors.secondary
  }
  
  convenience init(title: String, cornerRadius: CGFloat) {
    self.init(type: .system)
    setTitle(title, for: .normal)
    layer.cornerRadius = cornerRadius
    titleLabel?.font = .init(name: "Avenir", size: 18)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
