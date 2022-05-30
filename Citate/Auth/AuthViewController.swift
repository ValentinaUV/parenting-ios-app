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
  
  var viewModel: AuthViewModel!
  var delegate: AuthDelegate!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  func authenticate() {
    viewModel?.bindAuthViewModelToControllerSuccess = {
      self.authSucceeded()
    }
    viewModel?.bindAuthViewModelToControllerFail = {
      self.authFailedError()
    }
    viewModel?.authenticate()
  }
  
  private func authFailedError() {
    DispatchQueue.main.async {
      let vc = AuthPinViewController()
      vc.viewModel = AuthPinViewModel(storage: KeychainStorage())
      vc.delegate = self
      let topVC = UIApplication.topViewController()
      topVC.present(vc, animated: true, completion: nil)
    }
  }
}

extension AuthViewController: AuthPinViewDelegate {
  
  func authSucceeded() {
    DispatchQueue.main.async {
      let topVC = UIApplication.topViewController()
      topVC.dismiss(animated: true, completion: nil)
    }
    delegate.didSucceed()
  }
}
