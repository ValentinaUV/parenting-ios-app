//
//  QuotesManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation

protocol QuotesRepository {
    var delegate: QuotesRepositoryDelegate? {get set}
    
    func getQuotes()
    func getQuotesBy(order: Int, limit: Int)
}

class QuotesManager {
    
    var repository: QuotesRepository
    
    init(repository: QuotesRepository) {
        self.repository = repository
    }
    
    func getQuotes() {
        repository.getQuotes()
    }
    
    func getQuotesBy(order: Int, limit: Int) {
        repository.getQuotesBy(order: order, limit: limit)
    }
}
