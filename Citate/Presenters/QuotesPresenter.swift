//
//  QuotesPresenter.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation

//todo: here you can add all the bussines logic for fetching the quotes
class QuotesPresenter {
    
    private var view: QuotesView
    private var quotesManager: QuotesManager
    
    init(view: QuotesView, quotesManager: QuotesManager) {
        self.view = view
        self.quotesManager = quotesManager
        self.quotesManager.service.delegate = self
    }
    
    func getQuotes() {
        quotesManager.getQuotes()
    }
    
    func getDailyQuote() {
        
        let defaults = UserDefaults.standard
        let savedDate = defaults.string(forKey: Constants.userDefaults.dateKey)
        var order = defaults.integer(forKey: Constants.userDefaults.dateKey)
        let date = savedDate ?? "00/00/0000"
        let today = DateFormatter().getToday()
        
        if date < today {
            order += 1
            defaults.set(order, forKey: "dailyQuoteOrder")
            defaults.set(today, forKey: "dailyQuoteDate")
        }
        
        quotesManager.getQuotesBy(order: order, limit: 1)
    }
}

extension QuotesPresenter: FirestoreQuotesDelegate {
    
    func didFailWithError(error: Error) {
        view.showAlert(title: "", message: "Failed to retrieve the quotes.")
    }
    
    func didLoadQuotes(_ quotes: [Quote]) {
        view.reloadQuotes(quotes)
    }
}
