//
//  AuthViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 04.03.2022.
//

import UIKit

protocol AuthDelegate {
  func didSucceed()
}

class AuthViewController: UIViewController {
  
  var viewModel : AuthViewModel?
  var delegate: AuthDelegate!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  func authenticate() {
    viewModel?.bindAuthViewModelToControllerSuccess = {
      self.delegate.didSucceed()
      return
    }
    
    viewModel?.bindAuthViewModelToControllerFail = {
      self.authFailedError()
      return
    }
  }
  
  private func authFailedError() {
    DispatchQueue.main.async {
      let dialogMessage = UIAlertController(title: "Authentication failed", message: "You could not be verified, please try again.", preferredStyle: .alert)
      let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        self.authenticate()
      })
      dialogMessage.addAction(okButton)
      
      let topVC = self.topMostController()
      topVC.present(dialogMessage, animated: true, completion: nil)
    }
  }
  
  private func topMostController() -> UIViewController {
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
