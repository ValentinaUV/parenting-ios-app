//
//  LoadingView.swift
//  Citate
//
//  Created by Ungurean Valentina on 10.06.2022.
//

import UIKit
import SSSpinnerButton

class LoadingView: UIView {

  lazy var spinnerButton: SSSpinnerButton = {
    let button = SSSpinnerButton(title: "")
    button.frame = CGRect(x: (center.x - 30), y: (center.y - 30), width: 60, height: 60)
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    spinnerButton.translatesAutoresizingMaskIntoConstraints = false
    addSubview(spinnerButton)
    
    NSLayoutConstraint.activate([
      spinnerButton.centerXAnchor.constraint(equalTo:centerXAnchor),
      spinnerButton.centerYAnchor.constraint(equalTo:centerYAnchor),
      spinnerButton.widthAnchor.constraint(equalToConstant:60),
      spinnerButton.heightAnchor.constraint(equalToConstant:60),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func start() {
    spinnerButton.startAnimate(spinnerType: SpinnerType.ballSpinFade, spinnercolor: .systemTeal, spinnerSize: 70, complete: nil)
  }
  
  func stop() {
    spinnerButton.stopAnimate(complete: nil)
    removeFromSuperview()
  }
}
