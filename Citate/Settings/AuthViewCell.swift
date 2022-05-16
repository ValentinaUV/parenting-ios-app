//
//  AuthViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class AuthViewCell: UITableViewCell, IdentifiableViewCell {
  
  @Published var authSwitch: Bool!
  
  
  //TODO remove model from this class
//  private lazy var pinViewModel: PinViewModel = {
//    let storage = KeychainStorage()
//    let model = PinViewModel(storage: storage)
//    return model
//  }()
  
  private let switchView: UISwitch = {
    let switchView = UISwitch(frame: .zero)
    switchView.tag = 1
    switchView.onTintColor = .systemTeal
    return switchView
  }()
  
  func setupCell(authSwitch: Bool) {
    self.authSwitch = authSwitch
    initView()
  }
  
  private func initView() {
    textLabel?.text = Constants.settingsScreen.authLabel
    switchView.setOn(authSwitch, animated: true)
//    switchView.setOn(pinViewModel.getSwitchOn(), animated: true)

    switchView.addTarget(self, action: #selector(self.authSwitchChanged(_:)), for: .valueChanged)
    accessoryView = switchView
  }
  
  @objc func authSwitchChanged(_ sender : UISwitch!) {
    authSwitch = sender.isOn
  }
  
  func changeAuthSwitchView(authSwitch: Bool) {
    switchView.setOn(authSwitch, animated: true)
  }
}
