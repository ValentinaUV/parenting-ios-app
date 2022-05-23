//
//  SettingsViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 03.04.2022.
//

import UIKit
import Combine

class SettingsViewController: UIViewController, PinView {
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
      table.translatesAutoresizingMaskIntoConstraints = false
      table.register(AuthViewCell.self, forCellReuseIdentifier: AuthViewCell.identifier)
      table.register(PinViewCell.self, forCellReuseIdentifier: PinViewCell.identifier)
    return table
  }()
  
  lazy var viewModel = {
    SettingsViewModel()
  }()
  
  private var cancellables = Set<AnyCancellable>()
  private var authCell: AuthViewCell!
  private var pinCell: PinViewCell!
  private var backFromChildView = false
  private var backFromAction: PinAction = .create
  var pinSaved = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  func initView() {
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.settingsScreen.title
    
    if backFromChildView, backFromAction == .create, !pinSaved {
      authCell.changeAuthSwitchView(authSwitch: false)
      authCell.authSwitch = false
      pinCell.changeStatus(false)
    }
    backFromChildView = false
    pinSaved = false
  }
  
  private func showPinScreen() {
    let vc = PinViewController(action: backFromAction)
    vc.delegate = self
    if let navigationController = self.navigationController {
      backFromChildView = true
      navigationController.pushViewController(vc, animated: true)
    }
  }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let cellType = viewModel.getCellType(at: indexPath) else { return }
    tableView.deselectRow(at: indexPath, animated: true)

    switch cellType {
      case .auth: return
      case .pin:
        backFromAction = .change
        showPinScreen()
        return
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cells[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cellType = viewModel.getCellType(at: indexPath) else { return UITableViewCell() }
    
    switch cellType {
      case .auth:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthViewCell.identifier, for: indexPath) as? AuthViewCell else { fatalError("AuthViewCell xib does not exists") }
        cell.setupCell()
        self.authCell = cell
        self.subscribeToAuthSwitch()
        return cell
      case .pin:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PinViewCell.identifier, for: indexPath) as? PinViewCell else { fatalError("AuthViewCell xib does not exists") }
        cell.setupCell()
        self.pinCell = cell
        return cell
    }
  }
  
  private func subscribeToAuthSwitch() {
    authCell.$authSwitch
      .sink { auth in
        if let status = auth, self.pinCell != nil {
          self.pinCell.changeStatus(status)
          if status {
            self.backFromAction = .create
            self.showPinScreen()
          }
        }
      }
      .store(in: &cancellables)
  }
}
