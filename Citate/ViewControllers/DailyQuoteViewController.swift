//
//  DailyQuoteViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.01.2022.
//

import UIKit

class DailyQuoteViewController: UIViewController {
  
  var presenter: DailyQuotePresenter?
  var loadingView: LoadingView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.applyGradient(colors: [UIColor.systemTeal.cgColor, UIColor.white.cgColor],
                       locations: [0.0, 1.0], direction: .topToBottom)
    
    containerView.addSubview(titleLabel)
    containerView.addSubview(authorLabel)
    view.addSubview(containerView)
    loadingView = LoadingView(frame: view.frame)
    view.addSubview(loadingView)
    
    setupConstraints()
    loadDailyQuote()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      containerView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant:20),
      containerView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant:-30),
      containerView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant:20),
      containerView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant:-30),
      titleLabel.centerYAnchor.constraint(equalTo:containerView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor),
      authorLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor),
      authorLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant:10),
      loadingView.topAnchor.constraint(equalTo: view.topAnchor),
      loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
      loadingView.rightAnchor.constraint(equalTo: view.rightAnchor)
    ])
  }
  
  private func loadDailyQuote() {
    loadingView.start()
    presenter?.getDailyQuote()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.quoteScreen.title
  }
  
  let titleLabel:UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 26)
    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.numberOfLines = 0
    return label
  }()
  
  let authorLabel:UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = UIColor.systemTeal
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let containerView:UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.clipsToBounds = true
    return view
  }()
  
  private func display(quote: Quote) {
    titleLabel.text = quote.title
    authorLabel.text = quote.author
  }
}

//MARK: - QuotesView

extension DailyQuoteViewController: DailyQuotesView {
  
  func reloadQuote(_ quote: Quote) {
    DispatchQueue.main.async {
      self.loadingView.stop()
      self.display(quote: quote)
    }
  }
}
