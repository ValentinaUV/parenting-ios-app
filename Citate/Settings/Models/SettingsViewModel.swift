//
//  SettingsViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 22.03.2022.
//

import Foundation
import Combine

enum CellType {
  case auth, pin
}

protocol DisplayPinScreen {
  func showPinScreen(submittedAction: PinAction)
}

class SettingsViewModel {
  var cells = [[CellType.auth, CellType.pin]]
  var authCell: AuthViewCell!
  var pinCell: PinViewCell!
  var delegate: DisplayPinScreen!
  private var cancellables = Set<AnyCancellable>()
  
  func getCellType(at indexPath: IndexPath) -> CellType! {
    return cells[indexPath.section][indexPath.row]
  }
  
  func rowSelected(at indexPath: IndexPath) {
    guard let cellType = getCellType(at: indexPath) else { return }
    switch cellType {
      case .auth: return
      case .pin:
        delegate.showPinScreen(submittedAction: .change)
        return
    }
  }
  
  func prepareAuthCell(cell: AuthViewCell) -> AuthViewCell {
    let storage = KeychainStorage()
    cell.setupCell(viewModel: AuthSwitchViewModel(storage: storage))
    authCell = cell
    subscribeToAuthSwitch()
    return cell
  }
  
  func preparePinCell(cell: PinViewCell) -> PinViewCell {
    let storage = KeychainStorage()
    cell.setupCell(viewModel: PinViewModel(storage: storage, action: .create))
    pinCell = cell
    return cell
  }
  
  func disableAuthAndPin() {
    authCell.changeAuthSwitchView(authSwitch: false)
    authCell.authSwitch = false
    pinCell.changeStatus(false)
  }
  
  func subscribeToAuthSwitch() {
    authCell.$authSwitch
      .sink { auth in
        if let status = auth, self.pinCell != nil {
          self.pinCell.changeStatus(status)
          if status {
            self.delegate.showPinScreen(submittedAction: .create)
          }
        }
      }
      .store(in: &cancellables)
  }
}
