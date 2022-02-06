//
//  QuotesPresenter.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation

class QuotesPresenter {
  
  private var view: AllQuotesView
  private var quotesManager: QuotesManager
  private var quotes: [Quote] = []
  
  init(view: AllQuotesView, quotesManager: QuotesManager) {
    self.view = view
    self.quotesManager = quotesManager
    self.quotesManager.repository.delegate = self
  }
  
  func getQuotes() {
    quotesManager.getQuotes()
  }
  
  func getNumberOfQuotes() -> Int {
    return quotes.count
  }
  
  func getQuote(by index: Int) -> Quote {
    return quotes[index]
  }
}

//MARK: - QuotesRepositoryDelegate
extension QuotesPresenter: QuotesRepositoryDelegate {
  
  func didFailWithError(error: Error) {
    view.showAlert(title: "", message: "Failed to retrieve the quotes.")
  }
  
  func didLoadQuotes(_ quotes: [Quote]) {
    self.quotes = quotes
    view.reloadQuotes(quotes)
  }
}
