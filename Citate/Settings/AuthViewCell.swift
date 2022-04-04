//
//  AuthViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class AuthViewCell: SettingsViewCell {
  
  @Published var authSwitch: Bool
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    authSwitch = false
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initView() {
    super.initView()
    textLabel?.text = "Authentication"

    let switchView = UISwitch(frame: .zero)
    switchView.setOn(false , animated: true)
    switchView.tag = 1
    switchView.onTintColor = .systemTeal
    switchView.addTarget(self, action: #selector(self.authSwitchChanged(_:)), for: .valueChanged)
    accessoryView = switchView
  }
  
  @objc func authSwitchChanged(_ sender : UISwitch!) {
    authSwitch = sender.isOn
  }
}
