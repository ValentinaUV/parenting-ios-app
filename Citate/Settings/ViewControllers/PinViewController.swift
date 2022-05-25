//
//  PinViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.04.2022.
//

import UIKit
import Combine

protocol PinViewDelegate {
  var pinSaved: Bool {get set}
}

class PinViewController: UIViewController, AlertView {
  
  private var cancellables = Set<AnyCancellable>()
  var delegate: PinViewDelegate!
  var viewModel: PinViewModel?
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.allowsSelection = false
    table.register(PinInputCell.self, forCellReuseIdentifier: PinInputCell.identifier)
    return table
  }()
  
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
    if let message = viewModel?.tryToSave() {
      displayAlert(with: "Cannot validate the PIN", message: message)
    } else {
      delegate?.pinSaved = true
      _ = navigationController?.popViewController(animated: true)
    }
  }
}

// MARK: - UITableViewDataSource

extension PinViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.getNumberOfSections() ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return viewModel?.getSectionTitles()[section]
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: PinInputCell.identifier, for: indexPath) as? PinInputCell else { return UITableViewCell() }
    cell.setupCell()
    viewModel?.cells.append(cell)
    return cell
  }
}