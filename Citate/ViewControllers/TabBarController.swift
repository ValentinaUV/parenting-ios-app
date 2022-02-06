//
//  TabBarController.swift
//  Citate
//
//  Created by Ungurean Valentina on 02.02.2022.
//

import UIKit

class TabBarController: UITabBarController {
  
  var quotesTabNavigationController : UINavigationController!
  var dailyQuoteTabNavigationController : UINavigationController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setQuotesTabNavigationController()
    setDailyQuoteTabNavigationController()
    
    viewControllers = [quotesTabNavigationController, dailyQuoteTabNavigationController]
  }
  
  private func setQuotesTabNavigationController() {
    let quotesViewController = QuotesViewController()
    let presenter = QuotesPresenter(view: quotesViewController, quotesManager: QuotesManager(repository: FirestoreQuotesRepository()))
    quotesViewController.presenter = presenter
    quotesTabNavigationController = UINavigationController.init(rootViewController: quotesViewController)
    
    let quotesImage = UIImage(systemName: "house.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    let quotesItem = UITabBarItem(title: Constants.quotesScreen.title, image: quotesImage, tag: 0)
    quotesItem.selectedImage = UIImage(systemName: "house.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    quotesTabNavigationController.tabBarItem = quotesItem
  }
  
  private func setDailyQuoteTabNavigationController() {
    let dailyQuoteViewController = DailyQuoteViewController()
    let dailyQuotePresenter = DailyQuotePresenter(view: dailyQuoteViewController, quotesManager: QuotesManager(repository: FirestoreQuotesRepository()))
    dailyQuoteViewController.presenter = dailyQuotePresenter
    dailyQuoteTabNavigationController = UINavigationController.init(rootViewController: dailyQuoteViewController)
    
    let dailyImage = UIImage(systemName: "giftcard.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    let dailyQuoteItem = UITabBarItem(title: Constants.quoteScreen.title, image:  dailyImage, tag: 1)
    dailyQuoteItem.selectedImage = UIImage(systemName: "giftcard.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    dailyQuoteTabNavigationController.tabBarItem = dailyQuoteItem
  }
}
