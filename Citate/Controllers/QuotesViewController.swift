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
    var quotesManager = QuotesManager(quotesService: FirebaseQuotes())
    
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
        
        quotesManager.quotesService.delegate = self
        //todo: you are adding leading+trailing constraints already in relation to the view
        quotesTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        quotesTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
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
        quotesManager.getQuotes()
    }

}

extension QuotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //todo: always use quard instead of force unwrap
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QuoteTableViewCell

        cell.quote = quotes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
}
//todo: fetching the quotes should be moved to presenter
extension QuotesViewController: FirebaseQuotesDelegate {
    
    func didFailWithError(error: Error) {
        //todo: remove all prints from the project, it's ok to use them as a fast debuging tool, but it shouldn't be present when pushing the code
        print("Failed to retrieve the quotes.")
        print(error.localizedDescription)
    }
    
    func didLoadQuotes(_ quotes: [Quote]) {
        
        self.quotes = quotes
        DispatchQueue.main.async {
            self.quotesTableView.reloadData()
        }
    }
}

extension QuotesViewController: QuotesView {
    
}
