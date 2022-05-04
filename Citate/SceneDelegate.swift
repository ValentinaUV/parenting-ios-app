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
    
    ThemeConfigurator.setUp()
    
    let tabBarController = TabBarController()
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
//    showPrivacyProtectionWindow()
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    showPrivacyProtectionWindow()
    let quoteNotificationManager = QuoteNotificationManager(notificationManager: LocalNotificationManager())
    quoteNotificationManager.addNotification()
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
//    let authController = AuthViewController()
//    authController.delegate = self
//    authController.authenticate()
  }
  
  // MARK: Privacy Protection
  private var privacyProtectionWindow: UIWindow?
  
  private func showPrivacyProtectionWindow() {
    guard let windowScene = self.window?.windowScene else {
      return
    }
    
    privacyProtectionWindow = UIWindow(windowScene: windowScene)
    privacyProtectionWindow?.rootViewController = PrivacyProtectionViewController()
    privacyProtectionWindow?.windowLevel = .alert + 1
    privacyProtectionWindow?.makeKeyAndVisible()
  }
  
  private func hidePrivacyProtectionWindow() {
    privacyProtectionWindow?.isHidden = true
    privacyProtectionWindow = nil
  }
}

extension SceneDelegate: AuthDelegate {
  func didSucceed() {
    DispatchQueue.main.async {
      self.hidePrivacyProtectionWindow()
    }
  }
}
