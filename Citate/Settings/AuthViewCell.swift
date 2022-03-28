//
//  AuthViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class AuthViewCell: SettingsViewCell {
  
  private(set) var authSwitch : Bool {
    didSet {
      self.bindAuthViewCellToController()
    }
  }
  
  var bindAuthViewCellToController : (() -> ()) = {}
  
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
    imageView?.tintColor = .systemTeal

    let switchView = UISwitch(frame: .zero)
    switchView.setOn(authSwitch , animated: true)
    switchView.tag = 1
    switchView.addTarget(self, action: #selector(self.authSwitchChanged(_:)), for: .valueChanged)
    accessoryView = switchView
  }
  
  @objc func authSwitchChanged(_ sender : UISwitch!) {
    authSwitch = sender.isOn
  }
}
