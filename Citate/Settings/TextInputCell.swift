//
//  PinInputCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 08.04.2022.
//

import UIKit

//protocol TextInputCellDelegate: AnyObject {
//
//  func cell(_ cell: PinInputCell, didChangeValue value: String?)
//}

final class PinInputCell: UITableViewCell, IdentifiableViewCell {
  
  static var identifier: String { return String(describing: self) }
  
  private let textField:UITextField = {
    let field = UITextField()
//    (frame: CGRect(x: 20, y: 0, width: 300, height: 40))
//    field.placeholder = "tralala"
    field.isSecureTextEntry = true
    field.translatesAutoresizingMaskIntoConstraints = false
    field.font = UIFont.systemFont(ofSize: 20)
    field.keyboardType = .numberPad
    field.enablePasswordToggle()
    return field
  }()
  
  private let containerView:UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.clipsToBounds = true
    return view
  }()
  
  weak var delegate: TextInputCellDelegate?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView() {
    selectionStyle = .none
    self.contentView.addSubview(textField)
    setupConstraints()

    print("here is common init")
  }
  
  func setupConstraints() {
    NSLayoutConstraint.activate([
//      textField.heightAnchor.constraint(equalToConstant: 40),
      textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
    ])
  }
  
  func getInputValue() -> String! {
    return textField.text
  }
  
//  @objc private func textFieldEditingChanged(_ textField: UITextField) {
//    delegate?.cell(self, didChangeValue: textField.text)
//  }
}
