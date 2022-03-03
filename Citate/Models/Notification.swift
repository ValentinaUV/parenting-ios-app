//
//  Notification.swift
//  Citate
//
//  Created by Ungurean Valentina on 03.03.2022.
//

import Foundation

struct Notification {
  var id: String
  var title: String
  var body: String
  var datetime: DateComponents
  var repeats: Bool = false
}
