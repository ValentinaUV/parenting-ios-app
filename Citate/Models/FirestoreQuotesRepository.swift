//
//  FirestoreQuotesRepository.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation
import Firebase

protocol QuotesRepositoryDelegate {
  func didFailWithError(error: Error)
  func didLoadQuotes(_ quotes: [Quote])
}

extension QuotesRepositoryDelegate {
  func didFailWithError(error: Error) {}
}

class FirestoreQuotesRepository: QuotesRepository {
  
  let db: Firestore
  var delegate: QuotesRepositoryDelegate?
  
  init() {
    db = Firestore.firestore()
  }
  
  func getQuotes() {
    var quotes: [Quote] = []
    
    db.collection(Constants.FStoreQuotes.collectionName)
      .order(by: Constants.FStoreQuotes.orderField)
      .getDocuments { querySnapshot, error in
        quotes = []
        
        guard error == nil else { self.delegate?.didFailWithError(error: error!); return}
        
        if let snapshotDocuments = querySnapshot?.documents {
          for doc in snapshotDocuments {
            if let quote = self.decodeData(data: doc.data()) {
              quotes.append(quote)
            }
          }
          
          if let delegate = self.delegate {
            delegate.didLoadQuotes(quotes)
          }
        }
      }
  }
  
  private func decodeData(data: [String: Any]) -> Quote? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: data, options: []) {
      do {
        let quote = try JSONDecoder().decode(Quote.self, from: jsonData)
        return quote
      } catch {}
    }
    return nil
  }
  
  func getQuotesBy(order: Int, limit: Int) {
    var quotes: [Quote] = []
    db.collection(Constants.FStoreQuotes.collectionName)
      .whereField(Constants.FStoreQuotes.orderField, isGreaterThanOrEqualTo: order)
      .order(by: Constants.FStoreQuotes.orderField)
      .limit(to: limit)
      .getDocuments { querySnapshot, error in
        quotes = []
        
        guard error == nil else { self.delegate?.didFailWithError(error: error!); return}
        
        if let snapshotDocuments = querySnapshot?.documents {
          if snapshotDocuments.isEmpty && order != 1 {
            self.getQuotesBy(order: 1, limit: limit)
            return
          }
          
          for doc in snapshotDocuments {
            if let quote = self.decodeData(data: doc.data()) {
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
