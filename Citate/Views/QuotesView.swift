//
//  QuotesView.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import UIKit

protocol AllQuotesView: ShowAlert, UIViewController {
  func reloadQuotes(_ quotes: [Quote])
}

protocol DailyQuotesView: ShowAlert, UIViewController {
  func reloadQuote(_ quote: Quote)
}
