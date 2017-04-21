//
//  CustomTabbarItem.swift
//  CustomTabbar
//
//  Created by Sujan Vaidya on 4/3/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

protocol CustomTabbarItemDelegate: NSObjectProtocol {
  func tabbarItemTapped(view: UIView, sender: UIButton)
}

class CustomTabbarItem: UIView {
  
  var btn: UIButton!
  
  weak var delegate: CustomTabbarItemDelegate!
  
  override init (frame : CGRect) {
    super.init(frame : frame)
  }
  
  convenience init () {
    self.init(frame:CGRect.zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(item: UITabBarItem, index: Int) {
    guard let image = item.image,
      let title = item.title else {
        fatalError("add images to tabbar items")
    }
    btn = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
    btn.setTitle(title, for: .normal)
    index == 2 ? btn.setTitleColor(.white, for: .normal) : btn.setTitleColor(.gray, for: .normal)
    
    btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    btn.setImage(image, for: .normal)
    centerButtonImageAndTitle(button: btn)
    
    index == 2 ? btn.setTitleColor(.white, for: .selected) : btn.setTitleColor(UIColor(colorLiteralRed: 34/255, green: 205/255, blue: 204/255, alpha: 1), for: .selected)
    index == 2 ? btn.setImage(image, for: .selected) : btn.setImage(image, for: .selected)
    self.addSubview(btn)
    
    btn.addTarget(self, action: .buttonTapped, for: .touchUpInside)
  }
  
  func centerButtonImageAndTitle(button: UIButton) {
    let spacing: CGFloat = 10
    let imageSize = button.imageView!.frame.size
    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing / 2), right: 0)
    button.imageEdgeInsets = UIEdgeInsets(top: -(spacing), left: (button.frame.width - imageSize.width) / 2, bottom: 0, right: (button.frame.width - imageSize.width) / 2)
  }
  
  func clickedBtn(sender: UIButton) {
    delegate.tabbarItemTapped(view: self, sender: sender)
  }
  
}

fileprivate extension Selector {
  static let buttonTapped = #selector(CustomTabbarItem.clickedBtn(sender:))
}
