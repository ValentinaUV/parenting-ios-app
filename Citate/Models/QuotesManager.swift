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
    func getQuotesBy(order: Int, limit: Int)
}

struct QuotesManager {
    
    var quotesService: CloudQuotesService
    
    func getQuotes() {
        quotesService.getQuotes()
    }
    
    func getQuotesBy(order: Int, limit: Int) {
        quotesService.getQuotesBy(order: order, limit: limit)
    }
}
