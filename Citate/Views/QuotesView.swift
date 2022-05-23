//
//  QuotesView.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import UIKit

protocol AllQuotesView: AlertView, UIViewController {
  func reloadQuotes(_ quotes: [Quote])
}

protocol DailyQuotesView: AlertView, UIViewController {
  func reloadQuote(_ quote: Quote)
}
