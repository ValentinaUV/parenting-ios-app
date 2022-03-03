//
//  QuotesManagerTests.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 01.03.2022.
//

import XCTest
@testable import Citate

class QuotesManagerTests: XCTestCase {

  var quotesManager: QuotesManager!
  var mockFirestoreQuotesRepository: MockFirestoreQuotesRepository!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockFirestoreQuotesRepository = MockFirestoreQuotesRepository()
    quotesManager = QuotesManager(repository: mockFirestoreQuotesRepository)
  }
  
  override func tearDownWithError() throws {
    quotesManager = nil
    mockFirestoreQuotesRepository = nil
    try super.tearDownWithError()
  }

  func testGetQuotes() throws {
    quotesManager.getQuotes()
    XCTAssertEqual(
      mockFirestoreQuotesRepository.getQuotesCalled,
      1,
      "getQuotes method should be called once")
  }
  
  func testGetQuotesBy() throws {
    quotesManager.getQuotesBy(order: 4, limit: 3)
    XCTAssertEqual(
      mockFirestoreQuotesRepository.getQuotesByCalled,
      1,
      "getQuotesBy method should be called once")
    
    XCTAssertEqual(
      mockFirestoreQuotesRepository.order,
      4,
      "getQuotesBy method should be called with order=4")
    
    XCTAssertEqual(
      mockFirestoreQuotesRepository.limit,
      3,
      "getQuotesBy method should be called with limit=3")
  }
}
