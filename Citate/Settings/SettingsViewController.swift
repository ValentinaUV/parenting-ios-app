//
//  SettingsViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 16.03.2022.
//

import UIKit

class SettingsViewController: ViewController {

  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.register(AuthViewCell.self, forCellReuseIdentifier: AuthViewCell.identifier)
    table.register(PinViewCell.self, forCellReuseIdentifier: PinViewCell.identifier)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.allowsSelection = false
    return table
  }()
  
  lazy var viewModel = {
    SettingsViewModel()
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
    initViewModel()
  }
  
  func initView() {
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
  }
  
  func initViewModel() {
    viewModel.getSettings()
    viewModel.reloadTableView = { [weak self] in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.settingsScreen.title
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.cells.count
  }
  
  private func reloadRow(row: Int, section: Int) {
    self.tableView.beginUpdates()
    self.tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
    self.tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
//  func setNewPIN() {
//    let dialogMessage = UIAlertController(title: Constants.settingsScreen.pinAlert.title, message: "", preferredStyle: .alert)
//
//    dialogMessage.addTextField { (textField) in
//      textField.placeholder = Constants.settingsScreen.pinAlert.pinField
//    }
//
//    dialogMessage.addTextField { (textField) in
//      textField.placeholder = Constants.settingsScreen.pinAlert.confirmPinField
//    }
//    dialogMessage.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] (_) in
//      if let pwd = dialogMessage.textFields?[0].text, let pwd2 = dialogMessage.textFields?[1].text {
//        if pwd != pwd2 {
//          print("Passwords should be the same")
//          //do not close the alert
//          //show error message
//        } else {
//          //save pin to keychain
//          print(pwd)
//        }
//      }
//
//    }))
    
//    dialogMessage.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak self] (_) in
//      self?.authSwitch = false
//      self?.reloadRow(row: 0)
//    }))
    
//    self.present(dialogMessage, animated: true, completion: nil)
//  }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if viewModel.displayRow[viewModel.cells[indexPath.section][indexPath.row]] ?? false {
      return tableView.rowHeight
    }
    
    return 0.0
  }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cells[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if viewModel.cells[indexPath.section][indexPath.row] == AuthViewCell.identifier {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cells[indexPath.section][indexPath.row], for: indexPath) as? AuthViewCell else { fatalError("xib does not exists") }
        cell.bindAuthViewCellToController = {
          self.viewModel.displayRow[PinViewCell.identifier] = cell.authSwitch
          self.reloadRow(row: indexPath.row+1, section: indexPath.section)
        }
      return cell
    }
      
    guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cells[indexPath.section][indexPath.row], for: indexPath) as? SettingsViewCell else { fatalError("xib does not exists") }

    return cell
  }
}
