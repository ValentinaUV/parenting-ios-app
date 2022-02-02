//
//  ViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setUpNavigation()
  }
  
  private func setUpNavigation() {
    guard let navBar = self.navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = .systemTeal
    appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    navBar.standardAppearance = appearance
    navBar.scrollEdgeAppearance = appearance
  }
}
