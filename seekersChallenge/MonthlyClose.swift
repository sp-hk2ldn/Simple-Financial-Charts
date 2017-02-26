//// 291 gas = 145.5// water = 57.10 // 28.55 // electric 269 // 134.5 // hkbn 30
//  MonthlyClose.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import SwiftyJSON

class MonthlyClose: StockData {
    var name: String = ""
    var startDate: String = ""
    var endDate: String = ""
    private var dataPointsDictionary = [Date:Float]()
//    var dataPointsArray = []
    var dataPointsArray: [(Date, Float)] = []
    
    init(jsonData: JSON){
        super.init()
        print(jsonData)
        self.name = jsonData["dataset"]["name"].stringValue
        self.startDate = jsonData["dataset"]["start_date"].stringValue
        self.endDate = jsonData["dataset"]["start_date"].stringValue
        
        let dataPointsArray = jsonData["dataset"]["data"].arrayValue
        for dataPoint in dataPointsArray {
            let dataPointSubArray = dataPoint.arrayValue
            let dateString = dataPointSubArray[0].stringValue
            let dateFromString = createDateFromAPIString(dateString: dateString)
            self.dataPointsDictionary[dateFromString] = dataPointSubArray[1].floatValue
        }
        
        self.dataPointsArray = dataPointsDictionary
            .map{ ($0.key, $0.value) }
            .sorted(by: { $0.0.0.compare($0.1.0) == .orderedAscending })
    }
    
    func createDateFromAPIString(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let dateToReturn = formatter.date(from: dateString) else { print("cannot parse date"); return Date() }
        return dateToReturn
    }
}
