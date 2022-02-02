//
//  QuoteNotificationView.swift
//  Citate
//
//  Created by Ungurean Valentina on 29.01.2022.
//

import Foundation

class QuoteNotificationView: NotificationView {
  
  func addNotification(quote: Quote) {
    
    let manager = LocalNotificationManager()
    let notificationId = "dailyQuoteWithOrder\(quote.order)"
    let title = Constants.dailyQuoteNotificationTitle
    let body = "\(quote.title.prefix(45))..."
    
    manager.notifications = [
      Notification(id: notificationId, title: title, body: body, datetime: getDateComponents(), repeats: false)
    ]
    manager.scheduleNotifications()
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
