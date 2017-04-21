//
//  ViewController1.swift
//  CustomTabbar
//
//  Created by Sujan Vaidya on 4/3/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func tapped(_ sender: Any) {
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "testNotification"), object: nil)
  }
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
