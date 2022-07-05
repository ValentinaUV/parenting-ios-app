//
//  PinViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class PinViewCell: UITableViewCell, IdentifiableViewCell {
  
  var pin: String!
  var viewModel: PinViewModel!
  
  func setupCell(viewModel: PinViewModel) {
    self.viewModel = viewModel
    pin = self.viewModel.getPin()
    initView()
  }
  
  private func initView() {
    textLabel?.text = Constants.settingsScreen.pinLabel
    imageView?.tintColor = .systemTeal
    accessoryType = .disclosureIndicator
    guard let _ = pin else {disableCell(); return}
  }
  
  func disableCell() {
    isUserInteractionEnabled = false
    textLabel?.isEnabled = false
  }
  
  func changeStatus(_ status: Bool) {
    isUserInteractionEnabled = status
    textLabel?.isEnabled = status
    
    if !status {
      deletePin()
    }
  }
  
  private func deletePin() {
    viewModel.deletePin()
  }
}
