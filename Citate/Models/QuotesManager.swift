//
//  QuotesManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation

protocol CloudQuotesService {
    var delegate: FirebaseQuotesDelegate? {get set}
    
    func getQuotes()
    func getRandomQuote()
    func getDailyQuote()
}

struct QuotesManager {
    
    var quotesService: CloudQuotesService
    
    func getQuotes() {
        quotesService.getQuotes()
    }
    
    func getRandomQuote() {
        quotesService.getRandomQuote()
    }
    
    func getDailyQuote() {
        quotesService.getDailyQuote()
    }
}
