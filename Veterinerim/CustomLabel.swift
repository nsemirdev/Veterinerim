//
//  CustomLabel.swift
//  Veterinerim
//
//  Created by Emir Alkal on 11.02.2023.
//

import UIKit

final class CustomLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  convenience init(text: String,
                   alignment: NSTextAlignment,
                   textColor: UIColor = Colors.secondary,
                   font: UIFont = UIFont(name: "Avenir", size: 18)!,
                   minimumScale: CGFloat = 1) {
    
    self.init(frame: .zero)
    self.text = text
    textAlignment = alignment
    numberOfLines = 0
    self.textColor = textColor
    self.font = font
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = minimumScale
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
