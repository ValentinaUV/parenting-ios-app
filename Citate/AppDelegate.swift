//
//  AppDelegate.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.12.2021.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        registerLocalNotification()
        setupMainView()
        return true
    }
    
    private func setupMainView() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let initialViewController = QuotesViewController()
        let presenter = QuotesPresenter(view: initialViewController, quotesManager: QuotesManager(quotesService: FirebaseQuotes()))
        initialViewController.presenter = presenter
        navigationController.pushViewController(initialViewController, animated: false)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
   
}

