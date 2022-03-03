//
//  DateFormatterTests.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 22.02.2022.
//

import XCTest
@testable import Citate

class DateFormatterTests: XCTestCase {
  
  func testGetToday() throws {
    let dateFormatter = DateFormatter()
    let today = DateFormatter().getToday()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    XCTAssertEqual(today, dateFormatter.string(from: Date()))
  }
}
