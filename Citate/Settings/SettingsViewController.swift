//
//  SettingsViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 16.03.2022.
//

import UIKit

class SettingsViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
  
  var sectionTitles = ["Authentication"]
  var sectionContent = [["Authentication", "Change PIN"]]
  var authSwitch = false
  
  let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.translatesAutoresizingMaskIntoConstraints = false
    table.register(UITableViewCell.self, forCellReuseIdentifier: "settingsCell")
    table.allowsSelection = false
    return table
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
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
    return sectionTitles.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    guard sectionContent[section].count != 0 else {
      return sectionContent[0].count
    }
    
    return sectionContent[section].count
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    if indexPath.row == 0, indexPath.section == 0 {
      return CGFloat(55)
    }
    
    if indexPath.row == 1, indexPath.section == 0 {
      return authSwitch ? tableView.rowHeight : 0.0
    }

    return tableView.rowHeight
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
    cell.textLabel?.text = sectionContent[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
    cell.imageView?.tintColor = .systemTeal
    cell.accessoryType = .disclosureIndicator
    
    if indexPath.row == 0, indexPath.section == 0 {
      let switchView = UISwitch(frame: .zero)
      switchView.setOn(authSwitch, animated: true)
      switchView.tag = indexPath.row
      switchView.addTarget(self, action: #selector(self.authSwitchChanged(_:)), for: .valueChanged)
      cell.accessoryView = switchView
    }
    
    return cell
  }
  
  @objc func authSwitchChanged(_ sender : UISwitch!){
    authSwitch = sender.isOn
    self.tableView.beginUpdates()
    self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    self.tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
