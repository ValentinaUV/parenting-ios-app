//
//  ViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.12.2021.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var quotes: [Quote] = []
    var quotesManager = QuotesManager(quotesService: FirebaseQuotes())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quotesManager.quotesService.delegate = self
        
        tableView.dataSource = self
        title = Constants.quotesScreen.title
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constants.quotesScreen.quoteCellIdentifier, bundle: nil),
                           forCellReuseIdentifier: Constants.quotesScreen.quoteCellIdentifier)
        
        loadQuotes()
    
    }
    
    func loadQuotes() {
//        quotesManager.getQuotes()
        quotesManager.getDailyQuote()
    }
}

extension ViewController: FirebaseQuotesDelegate {
    
    func didFailWithError(error: Error) {
        print("Failed to retrieve the quotes.")
        print(error.localizedDescription)
    }
    
    func didLoadQuotes(_ quotes: [Quote]) {
        print("Quotes: ")
        
        self.quotes = quotes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didLoadRandomQuote(_ quote: Quote) {
        print("The quote: ")
        print(quote)
    }
    
    func didLoadDailyQuote(_ quote: Quote) {
        print("The quote: ")
        print(quote)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let quote = quotes[indexPath.row]
        
        return getQuoteCell(tableView, indexPath, quote: quote)
    }
    
    
    
    func getQuoteCell(_ tableView: UITableView, _ indexPath: IndexPath, quote: Quote) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.quotesScreen.quoteCellIdentifier, for: indexPath) as? QuoteCell else {
            return UITableViewCell()
        }
        
        cell.contentLabel.text = quote.title
        cell.authorLabel.text = quote.author
        
        return cell
    }
}

