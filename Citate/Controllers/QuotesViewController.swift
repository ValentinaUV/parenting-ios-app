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
    var quotes: [Quote] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(quotesTableView)
        quotesTableView.translatesAutoresizingMaskIntoConstraints = false
        quotesTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        quotesTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        quotesTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        quotesTableView.dataSource = self
        quotesTableView.delegate = self
        quotesTableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: "quoteCell")
        quotesTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        loadQuotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigation()
    }
    
    private func setUpNavigation() {
        guard let navBar = self.navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}

        navigationItem.title = Constants.quotesScreen.title

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemTeal
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = appearance
    }
    
    func loadQuotes() {
        presenter?.getQuotes()
    }

}

extension QuotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? QuoteTableViewCell else {
            return UITableViewCell()
        }

        cell.quote = quotes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
}

extension QuotesViewController: QuotesView {
    
    func reloadQuotes(_ quotes: [Quote]) {
        self.quotes = quotes
        DispatchQueue.main.async {
            self.quotesTableView.reloadData()
        }
    }
    
    func showAlert(title: String, message: String) {

        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        dialogMessage.addAction(okButton)
        
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
