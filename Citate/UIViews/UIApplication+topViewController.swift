//
//  UIApplication+topViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 30.05.2022.
//

import UIKit

extension UIApplication {
  
  class func topViewController() -> UIViewController {
    var topController: UIViewController = (UIApplication
      .shared
      .connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }?
      .rootViewController)!
    
    while (topController.presentedViewController != nil) {
      topController = topController.presentedViewController!
    }
    
    return topController
  }
}
