//
//  QuotesPresenter.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation

//todo: here you can add all the bussines logic for fetching the quotes
class QuotesPresenter {
    
    private var view: QuotesView
    private var quotesManager: QuotesManager
    
    init(view: QuotesView, quotesManager: QuotesManager) {
        self.view = view
        self.quotesManager = quotesManager
    }
    
}
