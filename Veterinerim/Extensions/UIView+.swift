//
//  UIView+.swift
//  Veterinerim
//
//  Created by Emir Alkal on 11.02.2023.
//

import UIKit

extension UIView {
  func addSubviews(_ subviews: UIView...) {
    subviews.forEach { addSubview($0) }
  }
}
