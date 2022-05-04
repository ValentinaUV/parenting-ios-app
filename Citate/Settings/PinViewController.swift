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
  
  private lazy var viewModel = {
    PinViewModel()
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
    let message: String!
    do {
      try viewModel.validateNewPin(cells[0].getInputValue(), cells[1].getInputValue())
      return true
    } catch PinError.minLength(let length) {
      message = "The PIN should have at least \(length) digits."
    } catch PinError.differentPins {
      message = "PINs should have the same value."
    } catch {
      message = "There is a validation error. Try again."
    }
    
    displayAlert(with: "Cannot validate the PIN", message: message)
    return false
  }
}

// MARK: - UITableViewDataSource

extension PinViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
      return Constants.pinScreen.section1
    } else if section == 1 {
      return Constants.pinScreen.section2
    }
    return ""
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PinInputCell.identifier, for: indexPath) as? PinInputCell else { fatalError("AuthViewCell xib does not exists") }
    cells.append(cell)
    return cell
  }
}
