//
//  TaskManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 11.01.2022.
//

import UIKit
import BackgroundTasks

class TaskManager {
    
    func registerBackgroundTaks() {
        
        print("registerBackgroundTaks func")
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constants.BGTaskAppRefreshId, using: nil) { task in
            self.handleDailyQuoteTask(task: task as! BGAppRefreshTask)
        }
    }
    
    func runTasks() {
        cancelAllPendingBGTask()
        scheduleDailyQuote()
    }
    
    private func cancelAllPendingBGTask() {
        BGTaskScheduler.shared.cancelAllTaskRequests()
    }
    
    private func scheduleDailyQuote() {
//        let request = BGProcessingTaskRequest(identifier: Constants.BGProcessingTaskrequestId)
//        request.requiresNetworkConnectivity = true // Need to true if your task need to network process. Defaults to false.
//        request.requiresExternalPower = false
        let request = BGAppRefreshTaskRequest(identifier: Constants.BGTaskAppRefreshId)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // Schedule notification after 1 minute.
        print("scheduleDailyQuote func")
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Task submitted")
        } catch {
            print("Could not schedule daily quote notification: \(error)")
        }
    }
    
    private func handleDailyQuoteTask(task: BGAppRefreshTask) {
        scheduleDailyQuote()
        print("handleDailyQuoteTask func")
        
        task.expirationHandler = {
            task.setTaskCompleted(success: false)
        }
        UserDefaults.standard.set(2, forKey: "bgtask")
        scheduleDailyLocalNotifications()
        task.setTaskCompleted(success: true)
    }
    
    private func scheduleDailyLocalNotifications() {
        print("scheduleDailyLocalNotification func")
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                let dailyQuoteManager = DailyQuoteManager()
                dailyQuoteManager.sendDailyQuoteNotifications()
            } else {
                print("Notifications are not authorized.")
            }
        }
    }
}
