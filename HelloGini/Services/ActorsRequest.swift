//
//  PersonRequest.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 21/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation
import Alamofire

class ActorsRequest {
    
    private let path = "people"
    
    func getActors(completion: @escaping (_ actors: [Actor]?, _ error: Error?) -> Void) {
        guard let request = HTTPRequest(path: path) else { return }
        
        request.fetchResult(completion: { (json, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let resultKey = "results"
            if let actorsJson = json?[resultKey] as? [[String:Any]] {
                let actors = Actor.getActorsFromJsonArray(actorsJson)
                completion(actors, nil)
                return
            }
        })
    }
    
    class func getFilmsFrom(actor: Actor, completion: @escaping (_ film: Film, _ inIndex: Int, _ ofActor: Actor) -> Void) {
        
        var actor = actor
        
        for url in actor.filmsStr.urls {

            HTTPRequest(url: url).fetchResult(completion: { (result, response, error) in
                if let error = error {
                    debugPrint(error)
                }
                
                guard let json = result,
                    let urlResponse = response?.url,
                    let index = actor.filmsStr.index(of: urlResponse.absoluteString) else { return }
                
                let film = Film(json: json)
                actor.insert(film: film, at: index)
                completion(film,index,actor)
            })
        }
    }
}
