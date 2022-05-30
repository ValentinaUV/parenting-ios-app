//
//  AuthPinViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 30.05.2022.
//

import Foundation

class AuthPinViewModel: PinModel {
  
  var storage: SettingsStorage
  
  init(storage: SettingsStorage) {
    self.storage = storage
  }
  
  func checkPin(_ pin: String) -> Bool {
    guard getPin() == pin else {return false}
    return true
  }
}
