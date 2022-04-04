//
//  ListView.swift
//  Citate
//
//  Created by Ungurean Valentina on 31.03.2022.
//

import UIKit

final class ListView: UITableView {
  lazy var tableView = UITableView(frame: .zero, style: .insetGrouped)

  init() {
    super.init(frame: .zero, style: .insetGrouped)
    
    initView()
//    setUpConstraints()
//    setUpViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.allowsSelection = false
    table.register(AuthViewCell.self, forCellReuseIdentifier: AuthViewCell.identifier)
    table.register(PinViewCell.self, forCellReuseIdentifier: PinViewCell.identifier)
  }
}
