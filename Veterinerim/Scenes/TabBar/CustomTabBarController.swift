//
//  CustomTabBarController.swift
//  custom-tab-bar
//
//  Created by Emir Alkal on 4.02.2023.
//

import UIKit

class CustomTabBarController: UITabBarController {
  override open func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Colors.primary
    let tabBar = CustomTabBar()
    tabBar.backgroundColor = Colors.secondary
    tabBar.layer.cornerRadius = 24
    tabBar.layer.maskedCorners = [
      .layerMinXMinYCorner,
      .layerMaxXMinYCorner
    ]
    setValue(tabBar, forKey: "tabBar")
    setupViewControllers()
  }

  private func setupViewControllers() {
    let vc1 = UIViewController()
    vc1.tabBarItem.image = UIImage(systemName: "house")
    vc1.tabBarItem.title = "Feed"
    vc1.view.backgroundColor = Colors.primary

    let vc2 = UIViewController()
    vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
    vc2.tabBarItem.title = "Search"
    vc2.view.backgroundColor = .blue

    let vc3 = UIViewController()
    vc3.tabBarItem.image = UIImage(systemName: "heart")
    vc3.tabBarItem.title = "Like"
    vc3.view.backgroundColor = .red

    let vc4 = UIViewController()
    vc4.tabBarItem.image = UIImage(systemName: "person")
    vc4.tabBarItem.title = "Profile"
    vc4.view.backgroundColor = .systemBackground

    viewControllers = [vc1, vc2, vc3, vc4]
  }
}
