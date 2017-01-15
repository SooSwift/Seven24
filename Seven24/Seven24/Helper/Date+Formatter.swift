//
//  Date+Formatter.swift
//  Seven24
//
//  Created by Sachin Sawant on 15/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

extension Date {
    
    // MARK:- Extension methods
    // Returns "Jan 15 @ 3:00 PM"
    func getDateAndTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d '@' h:mm a"
        return dateFormatter.string(from: self)
    }
    
    // Returns "Sunday, 15 Jan 2017"
    func getWeekdayAndDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM YYYY"
        return dateFormatter.string(from: self)
    }
    
    // Returns "3:00 PM"
    func get12HourTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }
    
}
