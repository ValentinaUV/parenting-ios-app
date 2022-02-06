//
//  QuotesView.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation

protocol QuotesView {
  func showAlert(title: String, message: String)
}

protocol AllQuotesView: QuotesView {
  func reloadQuotes(_ quotes: [Quote])
}

protocol DailyQuotesView: QuotesView {
  func reloadQuote(_ quote: Quote)
}
