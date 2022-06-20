//
//  AuthViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.03.2022.
//

import Foundation

class AuthViewModel: PinModel {
  
  var storage: SettingsStorage
  var biometrics: BiometricsHelper
  
  var bindAuthViewModelToControllerSuccess : (() -> ()) = {}
  var bindAuthViewModelToControllerFail : (() -> ()) = {}
  
  private(set) var authSucceeded : Bool {
    didSet {
      authSucceeded ? bindAuthViewModelToControllerSuccess() : bindAuthViewModelToControllerFail()
    }
  }
  
  init(storage: SettingsStorage) {
    self.storage = storage
    authSucceeded = false
    biometrics = BiometricsHelper()
    biometrics.delegate = self
  }
  
  func authenticate() {
    if let _ = getPin() {
      biometrics.authenticate()
    } else {
      authSucceeded = true
    }
  }
}

extension AuthViewModel: BiometricsHelperDelegate {
  
  func biometricsAuthDone(success: Bool) {
    authSucceeded = success
  }
}
