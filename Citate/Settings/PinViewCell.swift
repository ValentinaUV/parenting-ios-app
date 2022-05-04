//
//  PinViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class PinViewCell: UITableViewCell, IdentifiableViewCell {
  
  var pin: String!
  
  private lazy var viewModel = {
    PinViewModel()
  }()
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    pin = viewModel.getPin()
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
    
    // TODO temporary added, delete after adding the modals for new/save pin
    if status {
      viewModel.savePin(pin: "qwertty")
    }
    if !status {
      deletePin()
    }
  }
  
  private func deletePin() {
    viewModel.deletePin()
  }
  
  func savePin(_ pin: String) {
    viewModel.savePin(pin: pin)
  }
}
