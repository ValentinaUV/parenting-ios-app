//
//  UIView+shake.swift
//  Citate
//
//  Created by Ungurean Valentina on 30.05.2022.
//

import UIKit

extension UIView {
  func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
    let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
      self.transform = CGAffineTransform(translationX: translation, y: 0)
    }
    
    propertyAnimator.addAnimations({
      self.transform = CGAffineTransform(translationX: 0, y: 0)
    }, delayFactor: 0.2)
    
    propertyAnimator.startAnimation()
  }
}
