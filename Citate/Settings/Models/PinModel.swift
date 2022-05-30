//
//  PinModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 16.05.2022.
//

import Foundation

protocol PinModel {
  var storage: SettingsStorage { get set}
  func getPin() -> String!
}

extension PinModel {
  
  func getPin() -> String! {
    let pinStorageKey = Constants.pinScreen.pinStorageKey
    return storage.get(by: pinStorageKey)
  }
}
