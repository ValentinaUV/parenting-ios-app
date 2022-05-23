//
//  AlertView.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.01.2022.
//

import UIKit

protocol AlertView {
  func displayAlert(with title: String, message: String)
  func displayAlert(with title: String, message: String, type: UIAlertController.Style?,  actions: [UIAlertAction]?)
}

extension AlertView where Self: UIViewController {
  
  func displayAlert(with title: String, message: String) {

    let okAction = UIAlertAction(title: "Ok", style: .default) {_ in}
    displayAlert(with: title, message: message, type: .alert, actions: [okAction])
  }
  
  func displayAlert(with title: String, message: String, type: UIAlertController.Style? = .alert, actions: [UIAlertAction]? = nil) {
    
    guard presentedViewController == nil else { return }
    
    let alertController  = UIAlertController(title: title, message: message, preferredStyle: type ?? .alert)
    actions?.forEach({ action in
      alertController.addAction(action)
    })
    
    DispatchQueue.main.async {
      self.present(alertController, animated: true)
    }
  }
}
