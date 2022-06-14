//
//  QuotesViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.01.2022.
//

import UIKit

class QuotesViewController: UIViewController {
  
  var presenter: QuotesPresenter?
  let quotesTableView = UITableView()
  var loadingView: LoadingView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadingView = LoadingView(frame: view.frame)
    view.addSubview(quotesTableView)
    view.addSubview(loadingView)
    setupConstraints()
    quotesTableView.dataSource = self
    quotesTableView.delegate = self
    quotesTableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: QuoteTableViewCell.identifier)
    
    loadQuotes()
  }
  
  private func setupConstraints() {
    quotesTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      quotesTableView.topAnchor.constraint(equalTo:view.topAnchor),
      quotesTableView.leftAnchor.constraint(equalTo:view.leftAnchor),
      quotesTableView.rightAnchor.constraint(equalTo:view.rightAnchor),
      quotesTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
      loadingView.topAnchor.constraint(equalTo: view.topAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
      loadingView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }
  
  private func loadQuotes() {
    loadingView.start()
    presenter?.getQuotes()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.quotesScreen.title
  }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension QuotesViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter?.getNumberOfQuotes() ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.identifier, for: indexPath) as? QuoteTableViewCell else {
      return UITableViewCell()
    }
    
    cell.quote = presenter?.getQuote(by: indexPath.row)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

//MARK: - QuotesView

extension QuotesViewController: AllQuotesView {
  
  func reloadQuotes(_ quotes: [Quote]) {
    DispatchQueue.main.async {
      self.loadingView.stop()
      self.quotesTableView.reloadData()
    }
  }
}
