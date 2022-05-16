//
//  PinViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.04.2022.
//

import UIKit
import Combine

class PinViewController: UIViewController, ShowAlert {
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.allowsSelection = false
    table.register(PinInputCell.self, forCellReuseIdentifier: PinInputCell.identifier)
    return table
  }()
  
  private lazy var viewModel: PinViewModel = {
    let storage = KeychainStorage()
    let model = PinViewModel(storage: storage, action: .create)
    return model
  }()
  
  var cells: [PinInputCell] = []
  private var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
  }
  
  func initView() {
    tableView.dataSource = self
    tableView.delegate = self
    view.addSubview(tableView)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.pinScreen.title
  }
  
  @objc func saveTapped(_ sender: UIBarButtonItem) {
    if validate() {
      
    print("validated")
//      viewModel.savePin(pin: cells[0].getInputValue())
    }
  }

  func validate() -> Bool {
    if let pin = cells[0].getInputValue(), let confirmPin = cells[1].getInputValue() {
      if let message = viewModel.validateNewPin(pin, confirmPin) {
        displayAlert(with: "Cannot validate the PIN", message: message)
        return false
      }
      return true
    }
    return false
  }
}

// MARK: - UITableViewDataSource

extension PinViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.getNumberOfSections()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel.getSectionTitles()[section]
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PinInputCell.identifier, for: indexPath) as? PinInputCell else { fatalError("AuthViewCell xib does not exists") }
    cell.setupCell()
    cells.append(cell)
    return cell
  }
}
