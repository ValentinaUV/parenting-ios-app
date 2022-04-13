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
  
  let serviceKey = "auth-pin"
  let accountKey = "quotes"
  
  func getPin() -> String! {
    
    guard let data = KeychainHelper.standard.read(service: serviceKey, account: accountKey) else {return nil}
      
    let pin = String(data: data, encoding: .utf8)!
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

    let data = Data(pin.utf8)
    KeychainHelper.standard.save(data, service: serviceKey, account: accountKey)
    
    print("pin saved: \(pin)")
  }
  
  func deletePin() {
    KeychainHelper.standard.delete(service: serviceKey, account: accountKey)
    
    print("pin deleted")
  }
}
