//
//  IdentifiableViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 22.03.2022.
//

import UIKit

protocol IdentifiableViewCell {
  static var identifier: String {get}
}

extension IdentifiableViewCell {
  static var identifier: String { return String(describing: self) }
}
