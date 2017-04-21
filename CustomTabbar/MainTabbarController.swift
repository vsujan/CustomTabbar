//
//  MainTabbarController.swift
//  CustomTabbar
//
//  Created by Sujan Vaidya on 4/3/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(MainTabbarController.notificationHandler), name: NSNotification.Name(rawValue: "testNotification"), object: nil)
    
    self.tabBar.isHidden = true
    setup()
    self.selectedIndex = 2
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func setup() {
    let borderView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 54 - 1, width: self.tabBar.frame.width, height: 1))
    borderView.backgroundColor = UIColor.lightGray
    self.view.addSubview(borderView)
    
    let customTabBar = CustomTabbarView(frame: self.tabBar.frame)
    customTabBar.frame.size.height = 54
    customTabBar.frame.origin.y -= (customTabBar.frame.height - self.tabBar.frame.height)
    customTabBar.backgroundColor = UIColor.white
    self.view.addSubview(customTabBar)
    
    customTabBar.dataSource = self
    customTabBar.delegate = self
    customTabBar.setup()
  }
  
  func notificationHandler() {
    print("received notification")
  }
  
}

extension MainTabbarController: CustomTabBarDataSource {
  
  func tabBarItemsInCustomTabBar(tabBarView: CustomTabbarView) -> [UITabBarItem] {
    return self.tabBar.items!
  }
  
}

extension MainTabbarController: CustomTabBarDelegate {
  
  func didSelectViewController(tabBarView: CustomTabbarView, atIndex index: Int) {
    self.selectedIndex = index
  }
}
