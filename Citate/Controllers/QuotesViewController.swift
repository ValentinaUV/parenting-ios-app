//
//  QuotesViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.01.2022.
//

import UIKit

class QuotesViewController: UIViewController{

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QuoteTableViewCell

        cell.quote = quotes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
}

extension QuotesViewController: FirebaseQuotesDelegate {
    
    func didFailWithError(error: Error) {
        print("Failed to retrieve the quotes.")
        print(error.localizedDescription)
    }
    
    func didLoadQuotes(_ quotes: [Quote]) {
//        print("Quotes: \(quotes)")
        
        self.quotes = quotes
        DispatchQueue.main.async {
            self.quotesTableView.reloadData()
        }
    }
    
    func didLoadRandomQuote(_ quote: Quote) {
        print("The quote: ")
        print(quote)
    }
    
    func didLoadDailyQuote(_ quote: Quote) {
        print("The quote: ")
        print(quote)
        
        let manager = LocalNotificationManager()
        let title = Constants.dailyQuoteNotificationTitle
        let body = "\"\(quote.title)\" \(quote.author)"
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .minute, value: 2, to: Date())
        print("let date: \(date!)")
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date!)
        print("dateComponents: \(dateComponents)")

        manager.notifications = [
            Notification(id: UUID().uuidString, title: title, body: body, datetime: dateComponents)
        ]

        manager.schedule()
    }
    
    
}
