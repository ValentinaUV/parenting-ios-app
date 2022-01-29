//
//  SceneDelegate.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var quotesTabNavigationController : UINavigationController!
    var dailyQuoteTabNavigationController : UINavigationController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        guard let winScene = (scene as? UIWindowScene) else { return }
        
        setupMainView(winScene)
    }
    
    private func setupMainView(_ winScene: UIWindowScene) {
        
        window = UIWindow(windowScene: winScene)
        window?.backgroundColor = .white
        
        let tabBarController = UITabBarController()
        setQuotesTabNavigationController()
        setDailyQuoteTabNavigationController()
        
        tabBarController.viewControllers = [quotesTabNavigationController, dailyQuoteTabNavigationController]
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .selected)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
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
        let dailyQuotePresenter = QuotesPresenter(view: dailyQuoteViewController, quotesManager: QuotesManager(repository: FirestoreQuotesRepository()))
        dailyQuoteViewController.presenter = dailyQuotePresenter
        dailyQuoteTabNavigationController = UINavigationController.init(rootViewController: dailyQuoteViewController)
        
        let dailyImage = UIImage(systemName: "giftcard.fill")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        let dailyQuoteItem = UITabBarItem(title: Constants.quoteScreen.title, image:  dailyImage, tag: 1)
        dailyQuoteItem.selectedImage = UIImage(systemName: "giftcard.fill")?.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
        dailyQuoteTabNavigationController.tabBarItem = dailyQuoteItem
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        let quoteNotificationPresenter = QuoteNotificationPresenter(
            view: QuoteNotificationView(),
            quotesManager: QuotesManager(repository: FirestoreQuotesRepository())
        )
        quoteNotificationPresenter.scheduleNotificationQuote()
    }
}
