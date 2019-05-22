//
//  Date+Extensions.swift
//  check
//
//  Created by Saleh on 06/02/1440 AH.
//  Copyright © 1440 Saleh. All rights reserved.
//

import Foundation
import UIKit
extension Date {//To get the time from Piker
    static func calculateDate(hour: Int, minute: Int) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_PSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let calculatedDate = formatter.date(from: "\(hour):\(minute)")
        return calculatedDate!
    }
    
    func getHourMinute() -> (hour: Int, minute: Int) {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return (hour, minute)
    }
}
