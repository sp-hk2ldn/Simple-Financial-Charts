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
            return URL(string: "http://www.yahoo.com")!
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
        guard let urlWithoutPercentEncoding = url.removingPercentEncoding else { fatalError() }
        let endpoint = Endpoint<YahooServiceAPI>.init(url: urlWithoutPercentEncoding, sampleResponseClosure: sampleResponseClosure, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding, httpHeaderFields: headerAuthorization)
        return endpoint
    }
    
    static let serviceProvider = MoyaProvider<YahooServiceAPI>(endpointClosure: endpointClosure)
    
    static func makeRequest(api: YahooServiceAPI, queue: DispatchQueue?, collection: Bool, completion:@escaping ((Response) -> Void)){
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
