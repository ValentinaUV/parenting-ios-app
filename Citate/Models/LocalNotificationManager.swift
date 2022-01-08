//
//  LocalNotificationManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 06.01.2022.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    
    var notifications = [Notification]()
    
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            granted, error in

            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
                case .notDetermined: self.requestAuthorization()
                case .authorized, .provisional: self.scheduleNotifications()
                default: break
            }
        }
    }
    
    private func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = .default
            
            var date = DateComponents()
            date.hour = 14
            date.minute = 55

//            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: false)
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let e = error {
                    print("Notification error: \(e)")
                    return
                }

                print("Notification scheduled! — ID = \(notification.id)")
            }
        }
    }

}

struct Notification {
    var id: String
    var title: String
    var body: String
    var datetime: DateComponents
}
