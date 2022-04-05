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
      .sink (receiveCompletion: { completion in
        switch completion {
          case .finished:
            break
          case .failure(let error):
            print("Error message for authSwitch: \(error.localizedDescription)")
        }
      }, receiveValue: { auth in
        self.pinCell.isUserInteractionEnabled = auth
        self.pinCell.textLabel?.isEnabled = auth
        self.viewModel.settings.auth = auth
      })
      .store(in: &cancellables)
  }
}

// MARK: - UITableViewDataSource

extension SettingsAuthViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    if indexPath.row == 0 {
      guard let authCell = tableView.dequeueReusableCell(withIdentifier: AuthViewCell.identifier, for: indexPath) as? AuthViewCell else { fatalError("xib does not exists") }
//      authCell.authSwitch = viewModel.settings.auth
      self.authCell = authCell
      return authCell
    } else if indexPath.row == 1 {
      guard let pinCell = tableView.dequeueReusableCell(withIdentifier: PinViewCell.identifier, for: indexPath) as? PinViewCell else { fatalError("xib does not exists") }
      self.pinCell = pinCell
      return pinCell
    }

    return UITableViewCell()
  }
}
