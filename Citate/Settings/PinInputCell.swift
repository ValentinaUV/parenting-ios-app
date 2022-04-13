//
//  PinInputCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 08.04.2022.
//

import UIKit

final class PinInputCell: UITableViewCell, IdentifiableViewCell, UITextFieldDelegate {
  
  static var identifier: String { return String(describing: self) }
  
  private let textField:UITextField = {
    let field = UITextField()
    field.isSecureTextEntry = true
    field.translatesAutoresizingMaskIntoConstraints = false
    field.font = UIFont.systemFont(ofSize: 20)
    field.keyboardType = .numberPad
    field.enablePasswordToggle()
    return field
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    textField.delegate = self
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let updatedString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    return updatedString.count <= Constants.pinScreen.pinMaxLength
  }
  
  func getInputValue() -> String! {
    return textField.text
  }
}
