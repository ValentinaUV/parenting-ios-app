//
//  AuthPinView.swift
//  Citate
//
//  Created by Ungurean Valentina on 29.05.2022.
//

import UIKit

class AuthPinView: UIView, UITextInputTraits {
  
  var keyboardType: UIKeyboardType = .numberPad
  var didFinishedEnterPin:((String)-> Void)?
  var maxLength = Constants.pinScreen.pinLength
  let stack = UIStackView()
  
  var pin: String = "" {
    didSet {
      updateStack(by: pin)
      if pin.count == maxLength, let didFinishedEnterPin = didFinishedEnterPin {
        didFinishedEnterPin(pin)
      }
    }
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initView()
    showKeyboardIfNeeded()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AuthPinView {
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  private func showKeyboardIfNeeded() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showKeyboard))
    self.addGestureRecognizer(tapGesture)
  }
  
  @objc private func showKeyboard() {
    self.becomeFirstResponder()
  }
}

extension AuthPinView: UIKeyInput {
  
  var hasText: Bool {
    return pin.count > 0
  }
  
  func insertText(_ text: String) {
    if pin.count == maxLength {
      return
    }
    pin.append(contentsOf: text)
  }
  
  func deleteBackward() {
    if hasText {
      pin.removeLast()
    }
  }
  
  func delete() {
    var length = maxLength
    while length > 0 {
      deleteBackward()
      length -= 1
    }
  }
}

extension AuthPinView {
  private func initView() {
    addSubview(stack)
    stack.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      stack.topAnchor.constraint(equalTo: self.topAnchor),
      stack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    ])
    stack.axis = .horizontal
    stack.distribution = .fillEqually
    updateStack(by: pin)
  }
  
  private func emptyPin() -> UIView {
    let pin = Pin()
    pin.pin.backgroundColor = UIColor.black.withAlphaComponent(0.1)
    return pin
  }
  
  private func getPin() -> UIView {
    let pin = Pin()
    pin.pin.backgroundColor = .systemTeal
    return pin
  }
  
  private func updateStack(by pin: String) {
    var emptyPins:[UIView] = Array(0..<maxLength).map{_ in emptyPin()}
    let userPinLength = pin.count
    let pins:[UIView] = Array(0..<userPinLength).map{_ in getPin()}
    
    for (index, element) in pins.enumerated() {
      emptyPins[index] = element
    }
    stack.removeAllArrangedSubviews()
    for view in emptyPins {
      stack.addArrangedSubview(view)
    }
  }
}
