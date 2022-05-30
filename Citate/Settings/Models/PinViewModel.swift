//
//  PinViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 05.04.2022.
//

import Foundation

enum PinError: Error {
  case minLength(Int)
  case differentPins
}

enum PinAction {
  case create
  case change
  
  var titles: [String] {
    switch self {
      case .create:
        return Constants.pinScreen.createSections
      case .change:
        return Constants.pinScreen.changeSections
    }
  }
  
  var numberOfInputs: Int {
    switch self {
      case .create: return 2
      case .change: return 3
    }
  }
}

class PinViewModel: PinModel {
  
  var storage: SettingsStorage
  let pinStorageKey = Constants.pinScreen.pinStorageKey
  let action: PinAction
  var cells: [PinInputCell] = []
  
  init(storage: SettingsStorage, action: PinAction) {
    self.storage = storage
    self.action = action
  }
  
  func getNumberOfSections() -> Int{
    return action.numberOfInputs
  }
  
  func getSectionTitles() -> [String] {
    return action.titles
  }
  
  func preparePinInput(cell: PinInputCell) -> PinInputCell {
    cell.setupCell()
    cells.append(cell)
    return cell
  }
  
  func tryToSave() -> String! {
    let message: String!
    switch action {
      case .create: message = validateOnCreate()
      case .change: message = validateOnChange()
    }
    
    if message == nil {
      savePin(pin: cells[1].getInputValue())
      return nil
    }
    
    return message
  }
  
  private func validateOnCreate() -> String! {
    if let pin = cells[0].getInputValue(), let confirmPin = cells[1].getInputValue() {
      return validateNewPin(pin, confirmPin)
    }
    return "Missing PIN input values"
  }
  
  private func validateNewPin(_ pin: String, _ confirmPin: String) -> String! {
    
    guard pin.count >= Constants.pinScreen.pinLength else {
      return "The PIN should have at least \(Constants.pinScreen.pinLength) digits."
    }
    guard pin == confirmPin else {
      return "PINs should have the same value."
    }
    return nil
  }
  
  private func validateOnChange() -> String! {
    if let oldPin = cells[0].getInputValue(), let newPin = cells[1].getInputValue(), let confirmPin = cells[2].getInputValue() {
      
      guard oldPin == getPin() else {
        return "Old PIN is not valid."
      }
      return validateNewPin(newPin, confirmPin)
    }
    return "Missing PIN input values"
  }
  
  func savePin(pin: String) {
    storage.save(key: pinStorageKey, value: pin)
  }
  
  func deletePin() {
    storage.delete(by: pinStorageKey)
  }
}
