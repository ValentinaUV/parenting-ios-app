//
//  DailyQuotePresenterTests.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 28.02.2022.
//

import XCTest
@testable import Citate

class DailyQuotePresenterTests: XCTestCase {
  
  var view: MockDailyQuotesView!
  var repository: MockFirestoreQuotesRepository!
  var manager: MockQuotesManager!
  var preferences: MockUserStorage!
  var presenter: DailyQuotePresenter!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    view = MockDailyQuotesView()
    repository = MockFirestoreQuotesRepository()
    manager = MockQuotesManager(repository: repository)
    preferences = MockUserStorage()
  }
  
  override func tearDownWithError() throws {
    view = nil
    repository = nil
    manager = nil
    preferences = nil
    presenter = nil
    
    try super.tearDownWithError()
  }
  
  func testGetDailyQuoteDefaultOrderAndDate() throws {
    presenter = DailyQuotePresenter(
      view: view,
      quotesManager: manager,
      preferences: preferences)
    
    presenter.getDailyQuote()
    XCTAssertEqual(
      manager.getQuotesByCalled,
      1,
      "getQuotesBy method should be called once")
    
    XCTAssertEqual(
      manager.order,
      1,
      "getQuotesBy method should be called with order=1")
    
    XCTAssertEqual(
      manager.limit,
      1,
      "getQuotesBy method should be called with limit=1")
  }
  
  func testGetDailyQuoteCustomOrderAndDate() throws {
    preferences.dailyQuoteOrder = 5
    preferences.dailyQuoteDate = DateFormatter().getToday()
    presenter = DailyQuotePresenter(
      view: view,
      quotesManager: manager,
      preferences: preferences)
    
    presenter.getDailyQuote()
    
    XCTAssertEqual(
      manager.order,
      5,
      "getQuotesBy method should be called with order=5")
    
    XCTAssertEqual(
      manager.limit,
      1,
      "getQuotesBy method should be called with limit=1")
  }
  
  func testDidFailWithError() {
    presenter = DailyQuotePresenter(
      view: view,
      quotesManager: manager,
      preferences: preferences)
    
    let error = NSError(domain: "", code: 401,
                        userInfo: [ NSLocalizedDescriptionKey: "Error message"])
    
    presenter.didFailWithError(error: error)
    
    XCTAssertEqual(
      view.displayAlertCalled,
      1,
      "displayAlert method should be called once")
    
    XCTAssertEqual(
      view.alertTitle,
      "",
      "alert title should be empty")
    
    XCTAssertEqual(
      view.alertMessage,
      "Failed to retrieve the quotes.",
      "alert message should be: Failed to retrieve the quotes.")
  }
  
  func testDidLoadQuotes() {
    presenter = DailyQuotePresenter(
      view: view,
      quotesManager: manager,
      preferences: preferences)
    
    let quote = Quote(title: "Quote title", author: "Quote Author", order: 23)
    presenter.didLoadQuotes([quote])
    
    XCTAssertEqual(
      view.reloadQuoteCalled,
      1,
      "reloadQuote method should be called once")
    
    XCTAssertEqual(
      view.receivedQuote,
      quote,
      "the received quote should correspond")
  }
}
