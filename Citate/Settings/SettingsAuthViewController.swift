//
//  SettingsAuthViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 03.04.2022.
//

import UIKit
import Combine

class SettingsAuthViewController: ViewController {
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
      table.translatesAutoresizingMaskIntoConstraints = false
      table.allowsSelection = false
      table.register(AuthViewCell.self, forCellReuseIdentifier: AuthViewCell.identifier)
      table.register(PinViewCell.self, forCellReuseIdentifier: PinViewCell.identifier)
    return table
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
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    authCell.$authSwitch
      .sink (receiveCompletion: { completion in
          switch completion {
            case .finished:
              break
            case .failure(let error):
              print("Error message: \(error.localizedDescription)")
          }
        }, receiveValue: { auth in
        self.pinCell.isUserInteractionEnabled = auth
        self.pinCell.textLabel?.isEnabled = auth
        self.pinCell.detailTextLabel?.isEnabled = auth
      })
      .store(in: &cancellables)
  }
}

// MARK: - UITableViewDelegate

extension SettingsAuthViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    return tableView.rowHeight
  }
}

// MARK: - UITableViewDataSource

extension SettingsAuthViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return viewModel.cells[section].count
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 0 {
      guard let authCell = tableView.dequeueReusableCell(withIdentifier: AuthViewCell.identifier, for: indexPath) as? AuthViewCell else { fatalError("xib does not exists") }
      self.authCell = authCell
      return authCell
    } else if indexPath.row == 1 {
      guard let pinCell = tableView.dequeueReusableCell(withIdentifier: PinViewCell.identifier, for: indexPath) as? PinViewCell else { fatalError("xib does not exists") }
      self.pinCell = pinCell
      return pinCell
    }

    return UITableViewCell()
  }
  
//  private func bindViewModel() {
//    viewModel.$employees.sink { [weak self] _ in
//      self?.showTableView()
//    }.store(in: &cancellables)
//  }
}
