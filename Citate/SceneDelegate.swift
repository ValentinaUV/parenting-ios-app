//
//  SceneDelegate.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.12.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let winScene = (scene as? UIWindowScene) else { return }
    
    setupMainView(winScene)
  }
  
  private func setupMainView(_ winScene: UIWindowScene) {
    
    window = UIWindow(windowScene: winScene)
    window?.backgroundColor = .white
    
    let tabBarController = TabBarController()
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .selected)
    
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    let quoteNotificationManager = QuoteNotificationManager(notificationManager: LocalNotificationManager())
    quoteNotificationManager.addNotification()
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    let authController = AuthViewController()
    authController.authenticate()
  }
}
