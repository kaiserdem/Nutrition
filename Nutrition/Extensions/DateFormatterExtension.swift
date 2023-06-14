//
//  DateFormatter.swift
//  Nutrition
//
//  Created by kaiserdem  on 11.06.2023.
//

import Foundation

extension DateFormatter {
    
    convenience init(dateFormat: String, timeZoneUTC: Bool = false) {
        self.init()
        self.dateFormat = dateFormat
        if timeZoneUTC {
            self.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        }
    }
}
