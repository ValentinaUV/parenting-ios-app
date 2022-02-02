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
    }
  }
}

//MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    
    guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
      return
    }
    
    if let tabBarController = rootViewController as? UITabBarController {
      tabBarController.selectedIndex = 1
    }
    
    completionHandler()
  }
}
