//
//  PinViewCellModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 05.04.2022.
//

import Foundation

enum PinError: Error {
  case minLength(Int)
  case differentPins
}

class PinViewModel {
  
  let storage: SettingsStorage
  let pinStorageKey = Constants.pinScreen.pinStorageKey
  
  init(storage: SettingsStorage) {
    self.storage = storage
  }
  
  func getPin() -> String! {
    
    guard let pin = storage.get(by: pinStorageKey) else {return nil}
    print("get the pin: \(pin)")
    return pin
  }
  
  func getSwitchOn() -> Bool {
    var switchOn = false
    if let _ = getPin() {
      switchOn = true
    }
    return switchOn
  }
  
  func validateNewPin(_ pin1: String, _ pin2: String) throws {
    
    guard pin1.count >= Constants.pinScreen.pinMinLength else {
      throw PinError.minLength(Constants.pinScreen.pinMinLength)
    }
    
    guard pin1 == pin2 else {
      throw PinError.differentPins
    }
  }
  
  func savePin(pin: String) {
    storage.save(key: pinStorageKey, value: pin)
  }
  
  func deletePin() {
    storage.delete(by: pinStorageKey)
  }
}
