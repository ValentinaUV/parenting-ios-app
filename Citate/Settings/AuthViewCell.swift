//
//  AuthViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class AuthViewCell: UITableViewCell, SettingsViewCell {
  
  static var identifier: String { return String(describing: self) }
  @Published var authSwitch: Bool!
  
  private lazy var viewModel = {
    AuthViewCellModel()
  }()
  
  private let switchView: UISwitch = {
    let switchView = UISwitch(frame: .zero)
    switchView.tag = 1
    switchView.onTintColor = .systemTeal
    return switchView
  }()
  
  public override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    initView()
  }
  
  private func initView() {
    textLabel?.text = Constants.settingsScreen.authLabel

    switchView.setOn(authSwitch ?? false , animated: true)
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
