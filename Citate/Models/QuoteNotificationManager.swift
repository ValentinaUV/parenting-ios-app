//
//  QuoteNotificationManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 29.01.2022.
//

import Foundation

class QuoteNotificationManager {
  
  var notificationManager: NotificationManager
  
  init(notificationManager: NotificationManager) {
    self.notificationManager = notificationManager
  }
  
  func addNotification() {
    let notificationId = Constants.notifications.dailyNotificationId
    let title = Constants.notifications.dailyNotificationTitle
    let body = Constants.notifications.dailyNotificationContent
    
    let notifications = [
      Notification(id: notificationId, title: title, body: body, datetime: getDateComponents(), repeats: true)
    ]
    notificationManager.scheduleNotifications(notifications)
  }
  
  private func getDateComponents() -> DateComponents {
    let today = Date()
    let calendar = Calendar.current
    let calendarDate = calendar.date(byAdding: .day, value: 1, to: today)
    var dateComponents = calendar.dateComponents([.year, .month, .day], from: calendarDate!)
    dateComponents.hour = 09
    dateComponents.minute = 10
    
    return dateComponents
  }
}
