//
//  PinInputCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 08.04.2022.
//

import UIKit

final class PinInputCell: UITableViewCell, IdentifiableViewCell {
    
  private let textField:UITextField = {
    let field = UITextField()
    field.isSecureTextEntry = true
    field.translatesAutoresizingMaskIntoConstraints = false
    field.font = UIFont.systemFont(ofSize: 20)
    field.keyboardType = .numberPad
    field.enablePasswordToggle()
    return field
  }()
  
  func setupCell() {
    textField.delegate = self
    initView()
  }
  
  private func initView() {
    selectionStyle = .none
    self.contentView.addSubview(textField)
    setupConstraints()
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
    ])
  }
  
  func getInputValue() -> String! {
    return textField.text
  }
}

extension PinInputCell: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    return updatedString.count <= Constants.pinScreen.pinMaxLength
  }
}
