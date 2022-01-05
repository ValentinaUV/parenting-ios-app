//
//  FirebaseQuotes.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation
import Firebase

protocol FirebaseQuotesDelegate {
    func didFailWithError(error: Error)
    func didLoadQuotes(_ quotes: [Quote])
    func didLoadRandomQuote(_ quote: Quote)
    func didLoadDailyQuote(_ quote: Quote)
}

struct FirebaseQuotes: CloudQuotesService {
    
    let db = Firestore.firestore()
    var delegate: FirebaseQuotesDelegate?
    
    func getQuotes(){
        var quotes: [Quote] = []
        
        db.collection(Constants.FStoreQuotes.collectionName)
            .order(by: Constants.FStoreQuotes.dateField)
            .getDocuments { querySnapshot, error in
                quotes = []
                
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let title = data[Constants.FStoreQuotes.titleField] as? String, let author = data[Constants.FStoreQuotes.authorField] as? String {
                                let quote = Quote(title: title, author: author)
                                print("the quote: \(quote.title)")
                                quotes.append(quote)
                                
                                if let delegate = self.delegate {
                                    delegate.didLoadQuotes(quotes)
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func getRandomQuote() {
        print("getRandomQuote")
    }
    
    func getDailyQuote() {
        print("getDailyQuote")
    }
}
