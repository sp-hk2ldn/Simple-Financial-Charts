//
//  QuandlServiceAPI.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import Moya

enum QuandlServiceAPI {
    case getMonthlyClosingPriceDifferenceForPeriod(ticker: String, startDate: String, endDate: String)
    case getAllStockPriceHistory(ticker: String)
}

extension QuandlServiceAPI: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return QuandlServiceDirectory.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getMonthlyClosingPriceDifferenceForPeriod(let ticker, let startDate, let endDate):
            return "datasets/WIKI/\(ticker).json?column_index=4&start_date=\(startDate)&end_date=\(endDate)&collapse=monthly&transform=diff&api_key=\(AppConstant.QUANDL_API_KEY)"
        case .getAllStockPriceHistory(let ticker):
            return "datasets/WIKI/\(ticker).json?api_key=\(AppConstant.QUANDL_API_KEY)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        default:
            return .request
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self.method {
        case .get:
            return URLEncoding()
        default:
            return JSONEncoding()
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    
    
    var multipartBody: [Moya.MultipartFormData]? {
        return nil
    }
    
    var sampleData: Data {
        return Data()
    }
}
