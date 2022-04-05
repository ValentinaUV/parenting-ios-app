//
//  SettingsViewModel.swift
//  Citate
//
//  Created by Ungurean Valentina on 22.03.2022.
//

import Foundation
import Combine

class SettingsViewModel {
  var cells = [[AuthViewCell.identifier, PinViewCell.identifier]]
  @Published var settings: Settings
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    settings = Settings(auth: true, pin: "12345")
    subscribeToSettings()
  }
  
  private func subscribeToSettings() {
    $settings
      .sink (receiveCompletion: { completion in
        switch completion {
          case .finished:
            break
          case .failure(let error):
            print("Error message for settings: \(error.localizedDescription)")
        }
      }, receiveValue: { settings in
        self.saveSettings(settings)
      })
      .store(in: &cancellables)
  }
  
  private func saveSettings(_ settings: Settings) {
    if settings != self.settings {
      print("here are settings")
      print(settings)
    } else {
      print("settings are the same")
    }

  }
}
