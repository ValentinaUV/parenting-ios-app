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
    
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
    }
    
    func scheduleNotifications() {
        for notification in notifications {
            let content = UNMutableNotificationContent()
            content.title = notification.title
            content.body = notification.body
            content.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: notification.datetime, repeats: notification.repeats)
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
    var repeats: Bool = false
}
