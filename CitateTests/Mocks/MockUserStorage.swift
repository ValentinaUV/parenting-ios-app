//
//  MockUserStorage.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 28.02.2022.
//

import XCTest
@testable import Citate

class MockUserStorage: UserStorage {
  
  private var date: String?
  private var order: Int?
  
  var dailyQuoteDate: String? {
    get {
      return date
    }
    set {
      date = newValue
    }
  }
  
  var dailyQuoteOrder: Int? {
    get {
      return order
    }
    set {
      order = newValue
    }
  }
}
