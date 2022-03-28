//
//  AuthCellViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import Foundation

class AuthCellViewModel: SettingsCellViewModel {
  
  private(set) var auth : Bool {
    didSet {
      self.bindAuthCellViewModelToAuthViewCell()
    }
  }
  
  var bindAuthCellViewModelToAuthViewCell : (() -> ()) = {}
  
  required init() {
    auth = false
    getAuth()
  }
  
  func getAuth() {
    auth = true
  }
}
