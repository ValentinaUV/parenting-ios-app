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
    
    private func getToday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let today = dateFormatter.string(from: Date())
        
        return today
    }
    
    private func getTodayOrder() -> Int {
        let today = getToday()
        let savedData = getDailyDateAndOrder()
        var date = savedData.date
        var order = savedData.order
        if date < today {
            date = today
            order += 1
            setDateforDailyQuote(date: today, withOrder: order)
        }

        return order
    }
    
    private func getDailyDateAndOrder() -> (date: String, order: Int) {
        
        let defaults = UserDefaults.standard
        var date: String
        let savedDate = defaults.string(forKey: "dailyQuoteDate")
        var order = defaults.integer(forKey: "dailyQuoteOrder")
        
        if savedDate == nil || order == 0 {
            date = getToday()
            order = 1
            setDateforDailyQuote(date: date, withOrder: order)
        } else {
            date = savedDate!
        }
            
        return (date: date, order: order)
    }
    
    private func setDateforDailyQuote(date: String, withOrder order: Int) {
        let defaults = UserDefaults.standard
        defaults.set(order, forKey: "dailyQuoteOrder")
        defaults.set(date, forKey: "dailyQuoteDate")
    }
    
    private func setOrderForDailyQuote(_ order: Int) {
        let defaults = UserDefaults.standard
        defaults.set(order, forKey: "dailyQuoteOrder")
    }
    
    func getDailyQuote() {
        print("getDailyQuote")
        
        let savedOrder = getTodayOrder()
        print("Order: \(savedOrder)")
        
        db.collection(Constants.FStoreQuotes.collectionName)
            .whereField(Constants.FStoreQuotes.orderField, isGreaterThanOrEqualTo: savedOrder)
            .order(by: Constants.FStoreQuotes.orderField)
            .limit(to: 1)
            .getDocuments { querySnapshot, error in
                if let e = error {
                    self.delegate?.didFailWithError(error: e)
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        
                        for doc in snapshotDocuments {
                            let data = doc.data()

                            if let title = data[Constants.FStoreQuotes.titleField] as? String,
                                let author = data[Constants.FStoreQuotes.authorField] as? String,
                                let order = data[Constants.FStoreQuotes.orderField] as? Int {
                                
                                if savedOrder < order {
                                    setOrderForDailyQuote(order)
                                }
                                
                                let quote = Quote(title: title, author: author, order: order)

                                if let delegate = self.delegate {
                                    delegate.didLoadDailyQuote(quote)
                                }
                            }
                        }
                    }
                }
            }
    }
}
