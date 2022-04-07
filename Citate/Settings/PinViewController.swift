//
//  PinViewController.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.04.2022.
//

import UIKit

class PinViewController: ViewController {
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.title = Constants.pinScreen.title
  }
}
