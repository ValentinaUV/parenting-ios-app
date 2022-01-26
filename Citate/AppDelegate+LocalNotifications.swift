//
//  AppDelegate+LocalNotifications.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation
import NotificationCenter

extension AppDelegate {
    func registerLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]

        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
}
