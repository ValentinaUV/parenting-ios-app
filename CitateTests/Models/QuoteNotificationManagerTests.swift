//
//  QuoteNotificationManagerTests.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 03.03.2022.
//

import XCTest
@testable import Citate

class QuoteNotificationManagerTests: XCTestCase {
  var notificationManager: MockNotificationManager!
  var manager: QuoteNotificationManager!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    notificationManager = MockNotificationManager()
    manager = QuoteNotificationManager(notificationManager: notificationManager)
  }
  
  override func tearDownWithError() throws {
    notificationManager = nil
    manager = nil
    
    try super.tearDownWithError()
  }
  
  func testAddNotification() throws {
    XCTAssertEqual(
      notificationManager.scheduleNotificationsCalled,
      0,
      "scheduleNotifications method should not be called yet")
    
    manager.addNotification()
    XCTAssertEqual(
      notificationManager.scheduleNotificationsCalled,
      1,
      "scheduleNotifications method should be called once")
    let receivedType = "\(type(of: notificationManager.receivedNotifications[0]))"
    
    XCTAssertEqual(
      receivedType,
      "Notification",
      "scheduleNotifications method should be called with an array of Notification objects")
  }
}
