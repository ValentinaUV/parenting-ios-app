//
//  SettingsViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 03.04.2022.
//

import UIKit
import Combine

class SettingsViewController: UIViewController, PinViewDelegate {
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
      table.translatesAutoresizingMaskIntoConstraints = false
      table.register(AuthViewCell.self, forCellReuseIdentifier: AuthViewCell.identifier)
      table.register(PinViewCell.self, forCellReuseIdentifier: PinViewCell.identifier)
    return table
  }()
  
  var viewModel: SettingsViewModel?
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
    viewModel?.delegate = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.settingsScreen.title
    
    if backFromChildView, backFromAction == .create, !pinSaved {
      viewModel?.disableAuthAndPin()
    }
    backFromChildView = false
    pinSaved = false
  }
}

// MARK: - DisplayPinScreen

extension SettingsViewController: DisplayPinScreen {
  
  func showPinScreen(submittedAction: PinAction) {
    let vc = PinViewController()
    let storage = KeychainStorage()
    backFromAction = submittedAction
    let model = PinViewModel(storage: storage, action: submittedAction)
    vc.viewModel = model
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
    return viewModel?.cells.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel?.rowSelected(at: indexPath)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel?.cells[section].count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cellType = viewModel?.getCellType(at: indexPath) else { return UITableViewCell() }
    switch cellType {
      case .auth:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthViewCell.identifier, for: indexPath) as? AuthViewCell else { return UITableViewCell() }
        return viewModel?.prepareAuthCell(cell: cell) ?? UITableViewCell()
      case .pin:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PinViewCell.identifier, for: indexPath) as? PinViewCell else { return UITableViewCell() }
        return viewModel?.preparePinCell(cell: cell)  ?? UITableViewCell()
    }
  }
}
