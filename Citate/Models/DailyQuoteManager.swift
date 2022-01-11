//
//  DailyQuoteManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 10.01.2022.
//

import Foundation

class DailyQuoteManager: FirebaseQuotesDelegate {
    
    var quotesManager = QuotesManager(quotesService: FirebaseQuotes())
    var date: String
    var order: Int
    
    init() {
        let defaults = UserDefaults.standard
        let savedDate = defaults.string(forKey: "dailyQuoteDate")
        order = defaults.integer(forKey: "dailyQuoteOrder")
        date = savedDate ?? "00/00/0000"
        
        quotesManager.quotesService.delegate = self
    }
    
    func sendDailyQuoteNotifications() {
        
        let today = getToday()
        if date < today {
            date = today
            order += 1
            quotesManager.getQuotesBy(order: order, limit: 7)
        } else {
            print("Will not send notifications again.")
            return
        }
    }
    
    private func getToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let today = dateFormatter.string(from: Date())
        
        return today
    }
    
    private func setDateforDailyQuote(date: String, withOrder order: Int) {
        let defaults = UserDefaults.standard
        defaults.set(order, forKey: "dailyQuoteOrder")
        defaults.set(date, forKey: "dailyQuoteDate")
    }
    
    private func setOrderForDailyQuote(_ order: Int) {
        let defaults = UserDefaults.standard
        defaults.set(order, forKey: "dailyQuoteOrder")
    }
    
    func didFailWithError(error: Error) {
        print("Failed to retrieve the quotes.")
        print(error.localizedDescription)
    }
    
    func didLoadQuotes(_ quotes: [Quote]) {
        print("The loaded 7 quotes: ")
        print(quotes)
        
        if quotes.count > 0 {
            setDateforDailyQuote(date: date, withOrder: order)
        }

        let manager = LocalNotificationManager()
        let title = Constants.dailyQuoteNotificationTitle
        let today = Date()
        var daysToAdd = 0
        
        for quote in quotes {
            daysToAdd += 1
            let body = "\"\(quote.title)\" \(quote.author)"
            let calendar = Calendar.current
            let calendarDate = calendar.date(byAdding: .day, value: daysToAdd, to: today)
            
            var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: calendarDate!)
            dateComponents.hour = 09
            dateComponents.minute = 10
            print("dateComponents: \(dateComponents)")
            
            let notificationId = "dailyQuoteWithOrder\(quote.order)"
            manager.notifications = [
                Notification(id: notificationId, title: title, body: body, datetime: dateComponents, repeats: false)
            ]

            manager.scheduleNotifications()
        }
    }
}
