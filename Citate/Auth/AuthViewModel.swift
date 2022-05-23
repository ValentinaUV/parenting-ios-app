//
//  AuthViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.03.2022.
//

import LocalAuthentication
import Foundation

class AuthViewModel {
  
  var retryAttempts = 0
  let context: LAContext
  var error: NSError?
  let reason: String
  
  private(set) var authSucceeded : Bool {
    didSet {
      if authSucceeded {
        self.bindAuthViewModelToControllerSuccess()
      } else {
        self.bindAuthViewModelToControllerFail()
      }
    }
  }
  
  init() {
    context = LAContext()
    reason = "Identify yourself!"
    authSucceeded = false
    authenticate()
  }
    
  var bindAuthViewModelToControllerSuccess : (() -> ()) = {}
  var bindAuthViewModelToControllerFail : (() -> ()) = {}
  
  func authenticate() {
    
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
      authenticateWithPin()
      return
    }

    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
      [weak self] success, authenticationError in
      
      guard success else {
        self?.authenticateWithPin()
        return
      }
      self?.authSucceeded = true
    }
  }
  
  
  func authenticateWithPin() {
    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
      [weak self] success, error in
      self?.authSucceeded = success ? true : false
    }
  }
}
