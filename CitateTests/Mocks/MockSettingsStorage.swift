//
//  MockSettingsStorage.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 03.07.2022.
//

import XCTest
@testable import Citate

class MockSettingsStorage: SettingsStorage {
  var values: [String: String] = [:]
  var saveCalled = 0
  var deleteCalled = 0
  
  func get(by key: String) -> String! {
    if let value = values[key] {
      return value
    }
    return nil
  }
  
  func save(key: String, value: String) {
    values[key] = value
    saveCalled += 1
  }
  
  func delete(by key: String) {
    values[key] = nil
    deleteCalled += 1
  }
}
