//
//  AuthPinViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 29.05.2022.
//

import UIKit

protocol AuthPinViewDelegate {
  func authSucceeded()
}

class AuthPinViewController: UIViewController {
  
  var viewModel: AuthPinViewModel!
  var delegate: AuthPinViewDelegate!
  let pinView: AuthPinView = {
    let pinView = AuthPinView()
    pinView.becomeFirstResponder()
    return pinView
  }()
  
  let pinLabel: UILabel = {
    let label = UILabel()
    label.text = "Enter your PIN"
    label.textColor = .systemTeal
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  private func initView() {
    view.addSubview(pinView)
    view.addSubview(pinLabel)
    pinView.translatesAutoresizingMaskIntoConstraints = false
    pinLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      pinLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      pinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pinView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      pinView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      pinView.heightAnchor.constraint(equalToConstant: CGFloat(44)),
      pinView.widthAnchor.constraint(equalToConstant: CGFloat(300))
    ])
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    pinView.didFinishedEnterPin = {pin in
      self.checkPin(pin)
    }
  }
  
  private func checkPin(_ pin: String) {
    if let result = viewModel?.checkPin(pin), result {
      delegate.authSucceeded()
    } else {
      pinView.shake()
      pinView.delete()
    }
  }
}
