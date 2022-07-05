//
//  MockPinInputCell.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 05.07.2022.
//

import XCTest
@testable import Citate

class MockPinInputCell: PinInputCell {
  
  func setInputValue(_ value: String) {
    textField.text = value
  }
}
