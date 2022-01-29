//
//  QuotesManager.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation

protocol CloudQuotesRepository {
    var delegate: FirestoreQuotesRepositoryDelegate? {get set}
    
    func getQuotes()
    func getQuotesBy(order: Int, limit: Int)
}

class QuotesManager {
    
    var repository: CloudQuotesRepository
    
    init(repository: CloudQuotesRepository) {
        self.repository = repository
    }
    
    func getQuotes() {
        repository.getQuotes()
    }
    
    func getQuotesBy(order: Int, limit: Int) {
        repository.getQuotesBy(order: order, limit: limit)
    }
}
