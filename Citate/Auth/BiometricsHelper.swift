//
//  BiometricsHelper.swift
//  Citate
//
//  Created by Ungurean Valentina on 30.05.2022.
//

import Foundation
import LocalAuthentication

protocol BiometricsHelperDelegate {
  func biometricsAuthDone(success: Bool)
}

class BiometricsHelper {
  
  let context: LAContext
  var error: NSError?
  let reason: String
  var delegate: BiometricsHelperDelegate!
  
  init() {
    context = LAContext()
    reason = "Identify yourself!"
  }
  
  func authenticate() {
    guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
      self.delegate.biometricsAuthDone(success: false)
      return
    }

    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
        success, authenticationError in
      self.delegate.biometricsAuthDone(success: success)
    }
  }
}
