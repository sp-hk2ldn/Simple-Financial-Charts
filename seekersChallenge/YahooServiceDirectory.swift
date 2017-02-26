//
//  YahooServiceDirectory.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import Moya

class YahooServiceDirectory {
    static var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quote%20where%20symbol%20in%20(%22YHOO%22%2C%22AAPL%22%2C%22GOOG%22%2C%22MSFT%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=")!
        }
    }
    
    static var headerAuthorization: [String: String] {
        get {
            return ["X":"X"]
        }
    }
    
    static var endpointClosure = { (target: YahooServiceAPI) -> Endpoint<YahooServiceAPI> in
        let url = "\(target.baseURL)\(target.path)"
        let sampleResponseClosure = { EndpointSampleResponse.networkResponse(200, target.sampleData )}
//        guard let urlWithoutPercentEncoding = url.removingPercentEncoding else { fatalError() }
        let endpoint = Endpoint<YahooServiceAPI>.init(url: url, sampleResponseClosure: sampleResponseClosure, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding, httpHeaderFields: headerAuthorization)
        return endpoint
    }
    
    static let serviceProvider = MoyaProvider<YahooServiceAPI>(endpointClosure: endpointClosure)
    
    static func makeRequest(api: YahooServiceAPI, queue: DispatchQueue?, completion:@escaping ((Response) -> Void)){
        YahooServiceDirectory.serviceProvider.request(api, queue: queue, completion: { (result) in
            switch result {
            case .success(let response):
                do {
                    let _ = try response.filterSuccessfulStatusCodes()
                    completion(response)
                } catch {
                    handleApiErrorResponse(response: response)
                }
            case .failure(let error):
                handleMoyaError(error: error)
            }
        })
    }
    
    static private func handleApiErrorResponse(response: Moya.Response){
        switch response.statusCode {
        case 400...499:
        break //TODO:- handle errors
        case 500...599:
        break //TODO: look at server team in a smug way
        default:
            break
        }
    }
    
    static private func handleMoyaError(error: MoyaError) {
        switch error {
        case .jsonMapping(let response):
            print("unable to map \(response)")
        default:
            print(error)
        }
    }
    
    
}
