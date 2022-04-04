//
//  PinViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 24.03.2022.
//

import UIKit

class PinViewCell: SettingsViewCell {
  
  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initView() {
    super.initView()
    textLabel?.text = "Change PIN"
    imageView?.tintColor = .systemTeal
    accessoryType = .disclosureIndicator
  }
}
