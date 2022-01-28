//
//  DateFormatter.swift
//  Citate
//
//  Created by Ungurean Valentina on 28.01.2022.
//

import Foundation

extension DateFormatter {
    
    func getToday() -> String {
        
        self.dateFormat = "dd/MM/yyyy"
        let today = self.string(from: Date())
        
        return today
    }
}
