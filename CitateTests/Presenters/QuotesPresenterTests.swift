//
//  QuotesPresenterTests.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 03.03.2022.
//

import XCTest
@testable import Citate

class QuotesPresenterTests: XCTestCase {

  var view: MockAllQuotesView!
  var repository: MockFirestoreQuotesRepository!
  var manager: MockQuotesManager!
  var presenter: QuotesPresenter!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    view = MockAllQuotesView()
    repository = MockFirestoreQuotesRepository()
    manager = MockQuotesManager(repository: repository)
    presenter = QuotesPresenter(view: view, quotesManager: manager)
  }
  
  override func tearDownWithError() throws {
    view = nil
    repository = nil
    manager = nil
    presenter = nil
    try super.tearDownWithError()
  }

  func testGetQuotes() throws {
    presenter.getQuotes()
    XCTAssertEqual(
      manager.getQuotesCalled,
      1,
      "getQuotes method should be called once")
  }
  
  func testDidLoadQuotes() throws {
    
    let quotes = [
      Quote(title: "Quote1", author: "Author1", order: 1),
      Quote(title: "Quote2", author: "Author2", order: 2),
      Quote(title: "Quote3", author: "Author1", order: 3)
    ]
    
    presenter.didLoadQuotes(quotes)
    XCTAssertEqual(
      view.reloadQuotesCalled,
      1,
      "reloadQuotes method should be called once")
    
    XCTAssertEqual(
      view.receivedQuotes.count,
      3,
      "reloadQuotes method should be called with an array of 3 Quote objects")
    
    XCTAssertEqual(
      presenter.getNumberOfQuotes(),
      3,
      "getNumberOfQuotes method should return 3")
    
    XCTAssertEqual(
      presenter.getQuote(by: 1).title,
      "Quote2",
      "getQuote method should return the quote with title 'Quote2'")
  }
  
  func testDidFailWithError() {
    let error = NSError(domain: "", code: 401,
                        userInfo: [ NSLocalizedDescriptionKey: "Error message"])
    
    presenter.didFailWithError(error: error)
    
    XCTAssertEqual(
      view.showAlertCalled,
      1,
      "showAlert method should be called once")
  }
}
