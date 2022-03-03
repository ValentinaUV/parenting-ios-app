//
//  UserPreferences.swift
//  Citate
//
//  Created by Ungurean Valentina on 06.02.2022.
//

import Foundation

protocol UserStorage {
  var dailyQuoteDate: String? {get set}
  var dailyQuoteOrder: Int? {get set}
}

class UserPreferences: UserStorage {
  var userDefaults: UserDefaults
  
  init() {
    userDefaults = UserDefaults.standard
  }
  
  var dailyQuoteDate: String? {
    get {
      return userDefaults.string(forKey: Constants.userDefaults.dateKey)
    }
    set {
      userDefaults.set(newValue, forKey: Constants.userDefaults.dateKey)
    }
  }
  
  var dailyQuoteOrder: Int? {
    get {
      return userDefaults.integer(forKey: Constants.userDefaults.quoteOrderKey)
    }
    set {
      userDefaults.set(newValue, forKey: Constants.userDefaults.quoteOrderKey)
    }
  }
}
