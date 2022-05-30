//
//  AuthPinView.swift
//  Citate
//
//  Created by Ungurean Valentina on 29.05.2022.
//

import UIKit

class AuthPinView: UIView {
  var pin: String = ""
  var maxLength = Constants.pinScreen.pinMaxLength
  
  
}

extension AuthPinView {
  override var canBecomeFirstResponder: Bool {
    return true
  }
}

extension AuthPinView: UIKeyInput {
  
  var hasText: Bool {
    return pin.count > 0
  }
  
  func insertText(_ text: String) {
    print(text)
  }
  
  func deleteBackward() {
    print("Delete button pressed")
  }
}
