//
//  MockAllQuotesView.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 03.03.2022.
//

import XCTest
@testable import Citate

class MockAllQuotesView: UIViewController, AllQuotesView {
  
  var reloadQuotesCalled = 0
  var receivedQuotes: [Quote] = []
  var displayAlertCalled = 0
  
  func reloadQuotes(_ quotes: [Quote]) {
    reloadQuotesCalled += 1
    receivedQuotes = quotes
  }
  
  func displayAlert(with title: String, message: String) {
    displayAlertCalled += 1
  }
}
