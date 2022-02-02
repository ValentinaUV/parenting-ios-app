//
//  QuotesPresenter.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation

class QuotesPresenter {
    
    private var view: QuotesView
    private var quotesManager: QuotesManager
    
    init(view: QuotesView, quotesManager: QuotesManager) {
        self.view = view
        self.quotesManager = quotesManager
        self.quotesManager.repository.delegate = self
    }
    
    func getQuotes() {
        quotesManager.getQuotes()
    }
    
    func getDailyQuote() {
        
        let defaults = UserDefaults.standard
        let savedDate = defaults.string(forKey: Constants.userDefaults.dateKey)
        var quoteOrder = defaults.integer(forKey: Constants.userDefaults.quoteOrderKey)
        let date = savedDate ?? "00/00/0000"
        let today = DateFormatter().getToday()
        
        if date < today {
            quoteOrder += 1
            defaults.set(quoteOrder, forKey: Constants.userDefaults.quoteOrderKey)
            defaults.set(today, forKey: Constants.userDefaults.dateKey)
        }
        
        quotesManager.getQuotesBy(order: quoteOrder, limit: 1)
    }
}

//MARK: - QuotesRepositoryDelegate
extension QuotesPresenter: QuotesRepositoryDelegate {
    
    func didFailWithError(error: Error) {
        view.showAlert(title: "", message: "Failed to retrieve the quotes.")
    }
    
    func didLoadQuotes(_ quotes: [Quote]) {
        view.reloadQuotes(quotes)
    }
}
