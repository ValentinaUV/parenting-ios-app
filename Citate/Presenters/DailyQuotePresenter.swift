//
//  DailyQuotePresenter.swift
//  Citate
//
//  Created by Ungurean Valentina on 06.02.2022.
//

import Foundation

class DailyQuotePresenter {
  
  private var view: DailyQuotesView
  private var quotesManager: QuotesManager
  private let preferences: UserPreferences
  
  init(view: DailyQuotesView, quotesManager: QuotesManager) {
    self.view = view
    preferences = UserPreferences()
    self.quotesManager = quotesManager
    self.quotesManager.repository.delegate = self
    
  }
  
  func getDailyQuote() {
    let date = preferences.dailyQuoteDate
    var order = preferences.dailyQuoteOrder
    let today = DateFormatter().getToday()
    
    if date < today {
      order += 1
      preferences.dailyQuoteOrder = order
      preferences.dailyQuoteDate = today
    }
    
    quotesManager.getQuotesBy(order: order, limit: 1)
  }
}

//MARK: - QuotesRepositoryDelegate
extension DailyQuotePresenter: QuotesRepositoryDelegate {
  
  func didFailWithError(error: Error) {
    view.showAlert(title: "", message: "Failed to retrieve the quotes.")
  }
  
  func didLoadQuotes(_ quotes: [Quote]) {
    view.reloadQuote(quotes[0])
  }
}
