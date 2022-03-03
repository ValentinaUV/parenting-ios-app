//
//  MockAllQuotesView.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 03.03.2022.
//

import XCTest
@testable import Citate

class MockAllQuotesView: AllQuotesView {

  var reloadQuotesCalled = 0
  var receivedQuotes: [Quote] = []
  var showAlertCalled = 0
  
  func reloadQuotes(_ quotes: [Quote]) {
    reloadQuotesCalled += 1
    receivedQuotes = quotes
  }
  
  func showAlert(title: String, message: String) {
    showAlertCalled += 1
  }
}
