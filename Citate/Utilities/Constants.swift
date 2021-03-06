//
//  Constants.swift
//  Citate
//
//  Created by Ungurean Valentina on 01.01.2022.
//

import Foundation

struct Constants {
  
  struct quotesScreen {
    static let title = "Quotes"
    static let quoteCellIdentifier = "QuoteCell"
  }
  
  struct quoteScreen {
    static let title = "Daily Quote"
  }
  
  struct FStoreQuotes {
    static let collectionName = "quotes"
    static let titleField = "title"
    static let authorField = "author"
    static let orderField = "order"
  }
  
  struct userDefaults {
    static let quoteOrderKey = "dailyQuoteOrder"
    static let dateKey = "dailyQuoteDate"
    static let notificationQuoteOrderKey = "notificationQuoteOrder"
  }
  
  struct notifications {
    static let dailyNotificationTitle = "Parenting Daily Quote"
    static let dailyNotificationId = "dailyQuoteNotification"
    static let dailyNotificationContent = "Get inspired with today's quote!"
  }
  
  struct settingsScreen {
    static let title = "Settings"
    static let authLabel = "Authentication"
    static let pinLabel = "Change PIN"
    
    struct pinAlert {
      static let title = "Set New PIN"
      static let pinField = "Enter New PIN"
      static let confirmPinField = "Confirm New PIN"
    }
  }
  
  struct pinScreen {
    static let title = "Set new PIN"
    static let pinLength = 4
    static let createSections = [
      "New PIN (\(pinScreen.pinLength) digits)",
      "Confirm PIN"
    ]
    static let changeSections = [
      "Old Pin",
      "New PIN (\(pinScreen.pinLength) digits)",
      "Confirm PIN"
    ]
    static let pinStorageKey = "auth-pin"
  }
}
