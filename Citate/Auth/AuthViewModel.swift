//
//  AuthViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.03.2022.
//

import LocalAuthentication
import Foundation

class AuthViewModel: PinModel {
  
  var retryAttempts = 0
  let context: LAContext
  var error: NSError?
  let reason: String
  var storage: SettingsStorage
  
  var bindAuthViewModelToControllerSuccess : (() -> ()) = {}
  var bindAuthViewModelToControllerFail : (() -> ()) = {}
  
  private(set) var authSucceeded : Bool {
    didSet {
      if authSucceeded {
        bindAuthViewModelToControllerSuccess()
      } else {
        bindAuthViewModelToControllerFail()
      }
    }
  }
  
  init(storage: SettingsStorage) {
    self.storage = storage
    context = LAContext()
    reason = "Identify yourself!"
    authSucceeded = false
  }
  
  func authenticate() {
    if let _ = getPin() {
      authenticateWithBiometrics()
      return
    }

    authSucceeded = true
  }
  
  private func authenticateWithBiometrics() {
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
      authSucceeded = false
      return
    }
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
      [weak self] success, authenticationError in
      
      guard success else {
        self?.authSucceeded = false
        return
      }
      //        self?.authSucceeded = true
    }
  }
}
