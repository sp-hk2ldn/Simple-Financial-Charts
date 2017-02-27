//
//  StockPrice.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 27/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import SwiftyJSON

class StockPrice: JSONMappable {
    var name: String = ""
    var startDate: String?
    var endDate: String?
    private var dataPointsDictionary = [Date:Float]()
    var dataPointsArray: [(Date, Float)] = []
    
    var dates: [Date] = []
    var openPrices: [Double] = []
    var highPrice: [Double] = []
    var lowPrice: [Double] = []
    var closePrice: [Double] = []
    var tradingVolume: [Int] = []
    var exDividend: [Double] = []
    var splitRatio: [Int] = []
    var adjOpen: [Double] = []
    var adjHigh: [Double] = []
    var adjLow: [Double] = []
    var adjClose: [Double] = []
    var adjVolume: [Int] = []
    
    required init(jsonData: JSON){
        self.name = jsonData["dataset"]["name"].stringValue
        self.startDate = jsonData["dataset"]["start_date"].string
        self.endDate = jsonData["dataset"]["start_date"].string
        
        let dataPointsArray = jsonData["dataset"]["data"].arrayValue
        for dataPoint in dataPointsArray {
            let dataPointSubArray = dataPoint.arrayValue
            let dateString = dataPointSubArray[0].stringValue
            let dateFromString = Utils.createDateFromAPIString(dateString: dateString)
            self.dates.append(dateFromString)
            self.openPrices.append(dataPointSubArray[1].doubleValue)
            self.highPrice.append(dataPointSubArray[2].doubleValue)
            self.lowPrice.append(dataPointSubArray[3].doubleValue)
            self.closePrice.append(dataPointSubArray[4].doubleValue)
            self.tradingVolume.append(dataPointSubArray[5].intValue)
            self.exDividend.append(dataPointSubArray[6].doubleValue)
            let splitRatioTest = dataPointSubArray[7].floatValue
            if splitRatioTest < 1.0 || splitRatioTest > 1.0 {
                print("DIFFERENT SPLIT RATIO: \(splitRatioTest)")
            }
            self.splitRatio.append(dataPointSubArray[7].intValue)
            self.adjOpen.append(dataPointSubArray[8].doubleValue)
            self.adjHigh.append(dataPointSubArray[9].doubleValue)
            self.adjLow.append(dataPointSubArray[10].doubleValue)
            self.adjClose.append(dataPointSubArray[11].doubleValue)
            self.adjVolume.append(dataPointSubArray[12].intValue)
            
            
            
            self.dataPointsDictionary[dateFromString] = dataPointSubArray[1].floatValue
//            if self.dates.count == 250 {
//                break
//            }
            if dateFromString.compare(Date(timeIntervalSinceNow: -31536000)) == .orderedAscending {
                break
            }
        }
        
        self.dataPointsArray = dataPointsDictionary
            .map{ ($0.key, $0.value) }
            .sorted(by: { $0.0.0.compare($0.1.0) == .orderedAscending })
    }
    
}
