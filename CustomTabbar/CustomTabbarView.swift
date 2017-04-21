//
//  CustomTabbarView.swift
//  CustomTabbar
//
//  Created by Sujan Vaidya on 4/3/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol CustomTabBarDataSource: NSObjectProtocol {
  func tabBarItemsInCustomTabBar(tabBarView: CustomTabbarView) -> [UITabBarItem]
}

protocol CustomTabBarDelegate: NSObjectProtocol {
  func didSelectViewController(tabBarView: CustomTabbarView, atIndex index: Int)
}

class CustomTabbarView: UIView {
  
  weak var dataSource: CustomTabBarDataSource!
  weak var delegate: CustomTabBarDelegate!
  var tabBarItems: [UITabBarItem] = []
  
  var customTabBarItems: [CustomTabbarItem] = []
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup() {
    tabBarItems = dataSource.tabBarItemsInCustomTabBar(tabBarView: self)
    
    let containers = createTabBarItemContainers()
    createTabBarItems(containers: containers)
  }
  
  func createTabBarItems(containers: [CGRect]) {
    
    var index = 0
    for item in tabBarItems {
      let container = containers[index]
      let customTabBarItem = CustomTabbarItem(frame: container)
      if index == 2 {
        let diff = customTabBarItem.frame.width - customTabBarItem.frame.height
        var posY: CGFloat = 0
        if diff > 10 && diff < 20 {
          posY = customTabBarItem.frame.height / 2
        } else if diff > 20 {
          posY = customTabBarItem.frame.height / 1.5
        } else {
          posY = customTabBarItem.frame.height / 4
        }
        customTabBarItem.frame = CGRect(x: customTabBarItem.frame.origin.x, y: -posY, width: customTabBarItem.frame.width, height: customTabBarItem.frame.width)
        
        customTabBarItem.backgroundColor = UIColor(colorLiteralRed: 34/255, green: 205/255, blue: 204/255, alpha: 1)
        customTabBarItem.layer.cornerRadius = customTabBarItem.frame.height/2
        customTabBarItem.layer.borderWidth = 2
        customTabBarItem.layer.borderColor = UIColor.white.cgColor
        customTabBarItem.layer.masksToBounds = true
        customTabBarItem.layer.shouldRasterize = true
        customTabBarItem.layer.rasterizationScale = 10
      }
      customTabBarItem.setup(item: item, index: index)
      customTabBarItem.delegate = self
      self.addSubview(customTabBarItem)
      customTabBarItems.append(customTabBarItem)
      index += 1
    }
  }
  
//  override func layoutSubviews() {
//    super.layoutSubviews()
//    for i in 0..<customTabBarItems.count {
//      if i == 2 {
//        customTabBarItems[i].frame = CGRect(x: customTabBarItems[i].frame.origin.x - 3, y: customTabBarItems[i].frame.origin.y - 14, width: customTabBarItems[i].frame.width + 6, height: customTabBarItems[i].frame.height + 6)
//        customTabBarItems[i].backgroundColor = UIColor.green
//        customTabBarItems[i].layer.cornerRadius = customTabBarItems[i].frame.height/2
//        customTabBarItems[i].layer.borderWidth = 4
//        customTabBarItems[i].layer.borderColor = UIColor.white.cgColor
//      }
//    }
//  }
  
  func createTabBarItemContainers() -> [CGRect] {
    
    var containerArray = [CGRect]()
    for index in 0..<tabBarItems.count {
      let tabBarContainer = createTabBarContainer(index: index)
      containerArray.append(tabBarContainer)
    }
    return containerArray
  }
  
  func createTabBarContainer(index: Int) -> CGRect {
    let gap: CGFloat = 2
    let widthPerItem = self.frame.width / CGFloat(tabBarItems.count) - 2 * gap
    let tabBarContainerRect = CGRect(x: widthPerItem * CGFloat(index) + 2 * CGFloat(index) * gap + gap, y: 0, width: widthPerItem, height: self.frame.height)
    return tabBarContainerRect
  }
  
}

extension CustomTabbarView: CustomTabbarItemDelegate {
  
  func tabbarItemTapped(view: UIView, sender: UIButton) {
    for tabbarItem in customTabBarItems {
      for subview in tabbarItem.subviews {
        if let tabBtn = subview as? UIButton {
          tabBtn.isSelected = false
        }
      }
    }
    let index = customTabBarItems.index(of: view as! CustomTabbarItem)!
    sender.isSelected = true
    delegate.didSelectViewController(tabBarView: self, atIndex: index)
  }
}
