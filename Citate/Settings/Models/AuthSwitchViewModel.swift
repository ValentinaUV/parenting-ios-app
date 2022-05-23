//
//  AuthSwitchViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 16.05.2022.
//

import Foundation

class AuthSwitchViewModel: PinModel {
  
  var storage: SettingsStorage
  
  init(storage: SettingsStorage) {
    self.storage = storage
  }
  
  func getSwitchOn() -> Bool {
    var switchOn = false
    if let _ = getPin() {
      switchOn = true
    }
    return switchOn
  }
}
