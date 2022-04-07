//
//  SettingsViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 03.04.2022.
//

import UIKit
import Combine

class SettingsViewController: ViewController {
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
      table.translatesAutoresizingMaskIntoConstraints = false
      table.allowsSelection = false
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
    if backFromChildView {
      backFromChildView = false
      authCell.changeAuthSwitchView(authSwitch: false)
      authCell.authSwitch = false
    }
  }
  
  private func showPinScreen() {
    let vc = PinViewController()
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
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cells[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cellType = viewModel.getCellType(at: indexPath) else { return UITableViewCell() }
    
    switch cellType {
      case .auth:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthViewCell.identifier, for: indexPath) as? AuthViewCell else { fatalError("AuthViewCell xib does not exists") }
        self.authCell = cell
        self.subscribeToAuthSwitch()
        return cell
      case .pin:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PinViewCell.identifier, for: indexPath) as? PinViewCell else { fatalError("AuthViewCell xib does not exists") }
        self.pinCell = cell
        return cell
    }
  }
  
  private func subscribeToAuthSwitch() {
    authCell.$authSwitch
      .sink { auth in
        if let status = auth {
          self.pinCell.changeStatus(status)
          if status {
            self.showPinScreen()
          }
        }
      }
      .store(in: &cancellables)
  }
}
