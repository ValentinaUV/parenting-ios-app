//
//  UITextField.swift
//  Citate
//
//  Created by Ungurean Valentina on 08.04.2022.
//

import UIKit

extension UITextField {
  fileprivate func setPasswordToggleImage(_ button: UIButton) {
    if isSecureTextEntry {
      button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
    } else {
      button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
    }
    button.tintColor = .systemTeal
  }
  
  func enablePasswordToggle(){
    let button = UIButton(type: .custom)
    setPasswordToggleImage(button)
    button.frame = CGRect(x: CGFloat(self.frame.size.width - 15), y: CGFloat(5), width: CGFloat(15), height: CGFloat(15))
    button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
    self.rightView = button
    self.rightViewMode = .always
  }
  
  @IBAction func togglePasswordView(_ sender: Any) {
    self.isSecureTextEntry = !self.isSecureTextEntry
    setPasswordToggleImage(sender as! UIButton)
  }
}
