//
//  MockDailyQuotesView.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 02.03.2022.
//

import XCTest
@testable import Citate

class MockDailyQuotesView: UIViewController, DailyQuotesView {
  
  var reloadQuoteCalled = 0
  var receivedQuote: Quote?
  var displayAlertCalled = 0
  var alertTitle: String?
  var alertMessage: String?
  
  func reloadQuote(_ quote: Quote) {
    reloadQuoteCalled += 1
    receivedQuote = quote
  }
  
  func displayAlert(with title: String, message: String) {
    displayAlertCalled += 1
    alertTitle = title
    alertMessage = message
  }
}
