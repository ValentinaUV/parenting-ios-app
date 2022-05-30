//
//  PrivacyProtectionViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 11.03.2022.
//

import UIKit

class PrivacyProtectionViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(blurEffectView)
  }
}
