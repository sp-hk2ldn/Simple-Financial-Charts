//
//  YahooServiceAPI.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import Moya

enum YahooServiceAPI {
    case getStockInformation
}

extension YahooServiceAPI: TargetType {
    var baseURL: URL {
        switch self {
        default:
            return YahooServiceDirectory.baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getStockInformation:
            return "/"
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
