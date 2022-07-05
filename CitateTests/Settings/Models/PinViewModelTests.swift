//
//  PinViewModelTests.swift
//  CitateTests
//
//  Created by Ungurean Valentina on 04.07.2022.
//

import XCTest
@testable import Citate

class PinViewModelTests: XCTestCase {

  var storage: MockSettingsStorage!
  var pinViewModel: PinViewModel!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    storage = MockSettingsStorage()
  }

  override func tearDownWithError() throws {
    pinViewModel = nil
    storage = nil
    try super.tearDownWithError()
  }

  func testGetNumberOfSectionsOnCreate() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    XCTAssertEqual(
      pinViewModel.getNumberOfSections(),
      2,
      "pinViewModel should have 2 sections on create.")
  }
  
  func testGetSectionTitlesOnChange() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.change)
    XCTAssertEqual(
      pinViewModel.getSectionTitles(),
      PinAction.change.titles,
      "pinViewModel should have 3 sections titles on create.")
  }

  func testPreparePinInput() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    let cell = PinInputCell()
    XCTAssertEqual(
      pinViewModel.preparePinInput(cell: cell),
      pinViewModel.cells[0],
      "the changed cell should be saved to pinViewModel cells.")
  }
  
  func testTryToSaveOnCreateFailsMissingValues() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    let cell1 = MockPinInputCell()
    cell1.setInputValue("123")
    _ = pinViewModel.preparePinInput(cell: cell1)
    
    XCTAssertEqual(
      pinViewModel.tryToSave(),
      "Missing PIN input values",
      "Saving should fail.")
  }
  
  func testTryToSaveOnCreateFailsPinLength() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    let cell1 = MockPinInputCell()
    cell1.setInputValue("123")
    _ = pinViewModel.preparePinInput(cell: cell1)
    _ = pinViewModel.preparePinInput(cell: cell1)
    
    XCTAssertEqual(
      pinViewModel.tryToSave(),
      "The PIN should have at least \(Constants.pinScreen.pinLength) digits.",
      "Saving should fail.")
  }
  
  func testTryToSaveOnCreateFailsNotTheSame() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    let cell1 = MockPinInputCell()
    cell1.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell1)
    let cell2 = MockPinInputCell()
    cell2.setInputValue("1233")
    _ = pinViewModel.preparePinInput(cell: cell2)
    
    XCTAssertEqual(
      pinViewModel.tryToSave(),
      "PINs should have the same value.",
      "Saving should fail.")
  }
  
  func testTryToSaveOnCreateSuccess() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    let cell1 = MockPinInputCell()
    cell1.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell1)
    let cell2 = MockPinInputCell()
    cell2.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell2)
    
    let result = pinViewModel.tryToSave()
    XCTAssertEqual(
      result,
      nil,
      "Saving should succeed.")
    
    XCTAssertEqual(
      storage.saveCalled,
      1,
      "Storage save method should be called.")
  }
  
  func testTryToSaveOnChangeFailsWrongOldPin() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.change)
    let cell0 = MockPinInputCell()
    cell0.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell0)
    let cell1 = MockPinInputCell()
    cell1.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell1)
    let cell2 = MockPinInputCell()
    cell2.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell2)
    
    storage.save(key: pinViewModel.pinStorageKey, value: "1111")
    
    XCTAssertEqual(
      pinViewModel.tryToSave(),
      "Old PIN is not valid.",
      "Saving should fail.")
  }
  
  func testTryToSaveOnChangeSuccess() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.change)
    let cell0 = MockPinInputCell()
    cell0.setInputValue("1111")
    _ = pinViewModel.preparePinInput(cell: cell0)
    let cell1 = MockPinInputCell()
    cell1.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell1)
    let cell2 = MockPinInputCell()
    cell2.setInputValue("1234")
    _ = pinViewModel.preparePinInput(cell: cell2)
    
    storage.save(key: pinViewModel.pinStorageKey, value: "1111")
    
    let result = pinViewModel.tryToSave()
    XCTAssertEqual(
      result,
      nil,
      "Saving should succeed.")
    
    XCTAssertEqual(
      storage.saveCalled,
      2,
      "Storage save method should be called.")
  }
  
  func testDeletePin() {
    pinViewModel = PinViewModel(storage: storage, action: PinAction.create)
    pinViewModel.deletePin()
    XCTAssertEqual(
      storage.deleteCalled,
      1,
      "Storage delete method should be called.")
  }
}
