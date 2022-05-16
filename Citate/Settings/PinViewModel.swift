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

enum PinAction {
  case create
  case change
}

class PinViewModel {
  
  let storage: SettingsStorage
  let pinStorageKey = Constants.pinScreen.pinStorageKey
  let action: PinAction
  
  init(storage: SettingsStorage, action: PinAction) {
    self.storage = storage
    self.action = action
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
  
  func getNumberOfSections() -> Int{
    switch action {
      case .create: return 2
      case .change: return 3
    }
  }
  
  func getSectionTitles() -> [String] {
    switch action {
      case .create:
        return Constants.pinScreen.createSections
      case .change:
        return Constants.pinScreen.changeSections
    }
  }
  
  func validateNewPin(_ pin: String, _ confirmPin: String) -> String! {
    
    let message: String!
    guard pin.count >= Constants.pinScreen.pinMinLength else {
      message = "The PIN should have at least \(Constants.pinScreen.pinMinLength) digits."
      return message
    }
    
    guard pin == confirmPin else {
      message = "PINs should have the same value."
      return message
    }
    
    return nil
  }
  
  func savePin(pin: String) {
    storage.save(key: pinStorageKey, value: pin)
  }
  
  func deletePin() {
    storage.delete(by: pinStorageKey)
  }
}
