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
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    subscribeToAuthSwitch()
  }
  
  private func subscribeToAuthSwitch() {
    authCell.$authSwitch
      .sink { auth in
        if let status = auth {
          self.pinCell.changeStatus(status)
        }
      }
      .store(in: &cancellables)
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
        return cell
      case .pin:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PinViewCell.identifier, for: indexPath) as? PinViewCell else { fatalError("AuthViewCell xib does not exists") }
        if let _ = cell.pin {
          authCell.changeAuthSwitchView(authSwitch: true)
          tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
        }
        self.pinCell = cell
        return cell
    }
  }
}
