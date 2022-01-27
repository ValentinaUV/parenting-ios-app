//
//  QuotesManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation

protocol CloudQuotesService {
    var delegate: FirestoreQuotesDelegate? {get set}
    
    func getQuotes()
    func getQuotesBy(order: Int, limit: Int)
}

class QuotesManager {
    
    var service: CloudQuotesService
    
    init(service: CloudQuotesService) {
        self.service = service
    }
    
    func getQuotes() {
        service.getQuotes()
    }
    
    func getQuotesBy(order: Int, limit: Int) {
        service.getQuotesBy(order: order, limit: limit)
    }
}
