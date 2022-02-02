//
//  LocalNotificationManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 06.01.2022.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
  
  var notifications:[Notification] = [Notification]()
  
  func scheduleNotifications() {
    for notification in notifications {
      let content = UNMutableNotificationContent()
      content.title = notification.title
      content.body = notification.body
      content.sound = .default
      
      let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: notification.repeats)
      let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
      
      UNUserNotificationCenter.current().add(request) { error in
        if let _ = error {
          return
        }
      }
    }
  }
  
}

struct Notification {
  var id: String
  var title: String
  var body: String
  var datetime: DateComponents
  var repeats: Bool = false
}
