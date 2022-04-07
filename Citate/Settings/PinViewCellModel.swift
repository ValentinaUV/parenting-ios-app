//
//  PinViewCellModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 05.04.2022.
//

import Foundation

class PinViewCellModel {
  
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
