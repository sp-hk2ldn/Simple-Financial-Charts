//
//  Utils.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 27/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation

class Utils {
    static func createDateFromAPIString(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let dateToReturn = formatter.date(from: dateString) else { print("cannot parse date"); return Date() }
        return dateToReturn
    }
}
