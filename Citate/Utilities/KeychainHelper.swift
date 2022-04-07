//
//  KeychainHelper.swift
//  Citate
//
//  Created by Ungurean Valentina on 06.04.2022.
//

import Foundation

final class KeychainHelper {
  
  static let standard = KeychainHelper()
  private init() {}
  
  func read(service: String, account: String) -> Data? {
    
    let query = [
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecClass: kSecClassGenericPassword,
      kSecReturnData: true
    ] as CFDictionary
    
    var result: AnyObject?
    SecItemCopyMatching(query, &result)
    
    return (result as? Data)
  }
  
  func save(_ data: Data, service: String, account: String) {
    
    let query = [
      kSecValueData: data,
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
    ] as CFDictionary
    
    let status = SecItemAdd(query, nil)
    if status == errSecDuplicateItem {
      let query = [
        kSecAttrService: service,
        kSecAttrAccount: account,
        kSecClass: kSecClassGenericPassword,
      ] as CFDictionary
      
      let attributesToUpdate = [kSecValueData: data] as CFDictionary
      SecItemUpdate(query, attributesToUpdate)
    }
  }
  
  func delete(service: String, account: String) {
    
    let query = [
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecClass: kSecClassGenericPassword,
    ] as CFDictionary
    
    SecItemDelete(query)
  }
}
