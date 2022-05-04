//
//  ThemeConfigurator.swift
//  Citate
//
//  Created by Ungurean Valentina on 29.04.2022.
//

import UIKit

class ThemeConfigurator {
  
  static func setUp() {
    let navigationBarAppearance = UINavigationBar.appearance()
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .systemTeal
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    navigationBarAppearance.standardAppearance = appearance
    navigationBarAppearance.scrollEdgeAppearance = appearance
    
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.systemTeal], for: .selected)
    UIBarButtonItem.appearance().tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
  }
}
