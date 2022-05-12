//
//  KeychainStorage.swift
//  Citate
//
//  Created by Ungurean Valentina on 11.05.2022.
//

import Foundation

protocol SettingsStorage {
  func get(by key: String) -> String!
  func save(key: String, value: String)
  func delete(by key: String)
}

class KeychainStorage: SettingsStorage {
  
  let accountKey: String
  
  init(accountKey: String = "quotes") {
    self.accountKey = accountKey
  }
  
  func get(by key: String) -> String! {
    guard let data = KeychainHelper.standard.read(service: key, account: accountKey) else {return nil}
    
    let value = String(data: data, encoding: .utf8)!
    return value
  }
  
  func save(key: String, value: String) {
    
    let data = Data(value.utf8)
    KeychainHelper.standard.save(data, service: key, account: accountKey)
    
    print("value saved: \(value)")
  }
  
  func delete(by key: String) {
    KeychainHelper.standard.delete(service: key, account: accountKey)
    
    print("value deleted")
  }
}
