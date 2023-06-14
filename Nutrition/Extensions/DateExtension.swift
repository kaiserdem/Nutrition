//
//  DateExtension.swift
//  Nutrition
//
//  Created by kaiserdem  on 11.06.2023.
//

import Foundation

extension Date {
    
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
