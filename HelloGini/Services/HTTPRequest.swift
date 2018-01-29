//
//  HTTPRequest.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 21/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation
import Alamofire

class HTTPRequest {
    private let baseUrl = "https://swapi.co/api/"
    private let url: URL
    
    init?(path: String) {
        guard let url = URL(string: baseUrl+path) else {return nil}
        self.url = url
    }
    
    init(url: URL) {
        self.url = url
    }
    
    func fetchResult(completion: @escaping (_ json: [String:Any]?, _ response: HTTPURLResponse?, _ error: Error?)->Void) {
        
        Alamofire.request(url).responseJSON { (response) in
            if case let .failure(error) = response.result {
                completion(nil, response.response, error)
                return
            }
            
            guard case let .success(result) = response.result,
                let value = result as? [String:Any] else {
                return
            }
            
            completion(value, response.response, nil)
            
        }
    }
}
