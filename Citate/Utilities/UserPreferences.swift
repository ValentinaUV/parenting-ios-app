//
//  UserPreferences.swift
//  Citate
//
//  Created by Ungurean Valentina on 06.02.2022.
//

import Foundation

class UserPreferences {
  let defaults: UserDefaults
  
  init() {
    defaults = UserDefaults.standard
  }
  
  var dailyQuoteDate: String {
    get {
      let savedDate = defaults.string(forKey: Constants.userDefaults.dateKey)
      let date = savedDate ?? "00/00/0000"
      return date
    }
    set(date) {
      defaults.set(date, forKey: Constants.userDefaults.dateKey)
    }
  }
  
  var dailyQuoteOrder: Int {
    get {
      let order = defaults.integer(forKey: Constants.userDefaults.quoteOrderKey)
      return order
    }
    set(order) {
      defaults.set(order, forKey: Constants.userDefaults.quoteOrderKey)
    }
  }
}
