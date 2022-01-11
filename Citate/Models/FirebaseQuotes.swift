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
}

struct FirebaseQuotes: CloudQuotesService {
    
    let db = Firestore.firestore()
    var delegate: FirebaseQuotesDelegate?
    
    func getQuotes(){
        var quotes: [Quote] = []
        
        db.collection(Constants.FStoreQuotes.collectionName)
            .order(by: Constants.FStoreQuotes.orderField)
            .getDocuments { querySnapshot, error in
                quotes = []
                
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            
                            if let title = data[Constants.FStoreQuotes.titleField] as? String,
                                let author = data[Constants.FStoreQuotes.authorField] as? String,
                                let order = data[Constants.FStoreQuotes.orderField] as? Int {
                                
                                let quote = Quote(title: title, author: author, order: order)
                                quotes.append(quote)
                            }
                        }
                        
                        if let delegate = self.delegate {
                            delegate.didLoadQuotes(quotes)
                        }
                    }
                }
            }
    }
    
    func getQuotesBy(order: Int, limit: Int) {
        print("getDailyQuote")
        var quotes: [Quote] = []
        db.collection(Constants.FStoreQuotes.collectionName)
            .whereField(Constants.FStoreQuotes.orderField, isGreaterThanOrEqualTo: order)
            .order(by: Constants.FStoreQuotes.orderField)
            .limit(to: limit)
            .getDocuments { querySnapshot, error in
                quotes = []
                
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()

                            if let title = data[Constants.FStoreQuotes.titleField] as? String,
                                let author = data[Constants.FStoreQuotes.authorField] as? String,
                                let order = data[Constants.FStoreQuotes.orderField] as? Int {
                                
                                let quote = Quote(title: title, author: author, order: order)
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
}
