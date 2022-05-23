//
//  SettingsViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 22.03.2022.
//

import Foundation
import Combine

enum CellType {
  case auth, pin
}

class SettingsViewModel {
  var cells = [[CellType.auth, CellType.pin]]
  
  func getCellType(at indexPath: IndexPath) -> CellType! {
    return cells[indexPath.section][indexPath.row]
  }
}
