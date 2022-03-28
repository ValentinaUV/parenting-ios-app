//
//  SettingsViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 22.03.2022.
//

import Foundation

protocol SettingsCellViewModel {
  init()
}

class SettingsViewModel {
  var cells = [[AuthViewCell.identifier, PinViewCell.identifier]]
  var displayRow = [AuthViewCell.identifier: true, PinViewCell.identifier: false]
  var reloadTableView: (() -> Void)?
}
