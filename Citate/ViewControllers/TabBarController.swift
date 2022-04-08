//
//  TabBarController.swift
//  Citate
//
//  Created by Ungurean Valentina on 02.02.2022.
//

import UIKit

class TabBarController: UITabBarController {
  
  var quotesTabNavigationController: UINavigationController!
  var dailyQuoteTabNavigationController: UINavigationController!
  var settingsTabNavigationController: UINavigationController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .selected)
    UIBarButtonItem.appearance().tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    setQuotesTabNavigationController()
    setDailyQuoteTabNavigationController()
    setSettingsTabNavigationController()
    
    viewControllers = [quotesTabNavigationController, dailyQuoteTabNavigationController, settingsTabNavigationController]
  }
  
  private func setQuotesTabNavigationController() {
    let quotesViewController = QuotesViewController()
    let presenter = QuotesPresenter(view: quotesViewController, quotesManager: QuotesManager(repository: FirestoreQuotesRepository()))
    quotesViewController.presenter = presenter
    quotesTabNavigationController = UINavigationController.init(rootViewController: quotesViewController)
    
    let image = UIImage(systemName: "house.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    let item = UITabBarItem(title: Constants.quotesScreen.title, image: image, tag: 0)
    item.selectedImage = UIImage(systemName: "house.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    quotesTabNavigationController.tabBarItem = item
  }
  
  private func setDailyQuoteTabNavigationController() {
    let dailyQuoteViewController = DailyQuoteViewController()
    let dailyQuotePresenter = DailyQuotePresenter(
      view: dailyQuoteViewController,
      quotesManager: QuotesManager(repository: FirestoreQuotesRepository()),
      preferences: UserPreferences())
    dailyQuoteViewController.presenter = dailyQuotePresenter
    dailyQuoteTabNavigationController = UINavigationController.init(rootViewController: dailyQuoteViewController)
    
    let image = UIImage(systemName: "giftcard.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    let item = UITabBarItem(title: Constants.quoteScreen.title, image:  image, tag: 1)
    item.selectedImage = UIImage(systemName: "giftcard.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    dailyQuoteTabNavigationController.tabBarItem = item
  }
  
  private func setSettingsTabNavigationController() {
    let settingsViewController = SettingsViewController()
    settingsTabNavigationController = UINavigationController.init(rootViewController: settingsViewController)
    
    let image = UIImage(systemName: "gearshape.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
    let item = UITabBarItem(title: Constants.settingsScreen.title, image: image, tag: 2)
    item.selectedImage = UIImage(systemName: "gearshape.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
    settingsTabNavigationController.tabBarItem = item
  }
}
