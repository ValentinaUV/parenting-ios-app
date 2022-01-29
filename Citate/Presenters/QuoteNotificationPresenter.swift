//
//  QuoteNotificationPresenter.swift
//  Citate
//
//  Created by Ungurean Valentina on 10.01.2022.
//

import Foundation

class QuoteNotificationPresenter {
    
    private var view: NotificationView
    private var quotesManager: QuotesManager
    
    init(view: NotificationView, quotesManager: QuotesManager) {
        self.view = view
        self.quotesManager = quotesManager
        self.quotesManager.repository.delegate = self
    }
    
    func scheduleNotificationQuote() {
        
        let defaults = UserDefaults.standard
        let savedDate = defaults.string(forKey: Constants.userDefaults.dateKey)
        var quoteOrder = defaults.integer(forKey: Constants.userDefaults.quoteOrderKey)
        var notificationQuoteOrder = defaults.integer(forKey: Constants.userDefaults.notificationQuoteOrderKey)
        var date = savedDate ?? "00/00/0000"
        let today = DateFormatter().getToday()
        
        if notificationQuoteOrder == 0 {
            if quoteOrder == 0 {
                quoteOrder = 1
                date = today
            }
            notificationQuoteOrder = quoteOrder
        }
        
        if date < today {
            quoteOrder += 1
        }
    
        if notificationQuoteOrder == quoteOrder {
            notificationQuoteOrder += 1
            defaults.set(notificationQuoteOrder, forKey: Constants.userDefaults.notificationQuoteOrderKey)
            quotesManager.getQuotesBy(order: notificationQuoteOrder, limit: 1)
        }
    }
}

extension QuoteNotificationPresenter: FirestoreQuotesRepositoryDelegate {
    
    func didLoadQuotes(_ quotes: [Quote]) {
        view.addNotification(quote: quotes[0])
    }
}
