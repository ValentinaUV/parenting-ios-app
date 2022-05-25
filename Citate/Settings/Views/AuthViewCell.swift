//
//  AuthViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class AuthViewCell: UITableViewCell, IdentifiableViewCell {
  
  @Published var authSwitch: Bool!
  var viewModel: AuthSwitchViewModel!
  
  private let switchView: UISwitch = {
    let switchView = UISwitch(frame: .zero)
    switchView.tag = 1
    switchView.onTintColor = .systemTeal
    return switchView
  }()
  
  func setupCell(viewModel: AuthSwitchViewModel) {
    self.viewModel = viewModel
    initView()
  }
  
  private func initView() {
    textLabel?.text = Constants.settingsScreen.authLabel
    switchView.setOn(viewModel.getSwitchOn(), animated: true)
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
