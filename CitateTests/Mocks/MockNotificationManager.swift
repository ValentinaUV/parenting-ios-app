//
//  MockNotificationManager.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 02.03.2022.
//

import XCTest
@testable import Citate

class MockNotificationManager: NotificationManager {
  
  var scheduleNotificationsCalled = 0
  var receivedNotifications: [Citate.Notification] = []
  func scheduleNotifications(_ notifications: [Citate.Notification]) {
    scheduleNotificationsCalled += 1
    receivedNotifications = notifications
  }
}
