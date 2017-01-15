//
//  Date+Formatter.swift
//  Seven24
//
//  Created by Sachin Sawant on 15/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

extension Date {
    
    func getDayAndTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d '@' h:mm a"
        return dateFormatter.string(from: self)
    }
    
}
