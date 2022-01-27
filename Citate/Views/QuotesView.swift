//
//  QuotesView.swift
//  Citate
//
//  Created by Codrut Merlusca on 18.01.2022.
//

import Foundation

protocol QuotesView {
    
    func reloadQuotes(_ quotes: [Quote])
    func showAlert(title: String, message: String)
}
