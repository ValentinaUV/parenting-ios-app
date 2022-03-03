//
//  MockQuotesManager.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 02.03.2022.
//

import XCTest
@testable import Citate

class MockQuotesManager: QuotesManager {
  
  var getQuotesCalled = 0
  var getQuotesByCalled = 0
  var order: Int?
  var limit: Int?
  
  override func getQuotes() {
    getQuotesCalled += 1
  }
  
  override func getQuotesBy(order: Int, limit: Int) {
    getQuotesByCalled += 1
    self.order = order
    self.limit = limit
  }
}
