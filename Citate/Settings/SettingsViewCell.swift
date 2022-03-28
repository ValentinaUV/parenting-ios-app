//
//  SettingsViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 22.03.2022.
//

import UIKit

class SettingsViewCell: UITableViewCell {
  
  class var identifier: String { return String(describing: self) }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    initView()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func initView() {}

}
