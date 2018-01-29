//
//  PersonRequest.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 21/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

class ActorsRequest {
    
    private let path = "people"
    
    func getPeople(completion: @escaping (_ people: [Actor]?, _ error: Error?) -> Void) {
        
        guard let request = HTTPRequest(path: path) else { return }
        
        request.fetchResult(completion: { (data, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            guard let data = data else { return }
            do {
                if let actors = try JSONDecoder().decode(ActorResult.self, from: data).results {
                    
                    var finished = actors.count
                    
                    for actor in actors {
                        if let urls = actor.filmsStr?.urls {
                            
                            var films = [Film]()
                            
                            DownloadManager<Film>(urls: urls, completion: { (film, index) in
                                
                                films.append(film)
                                
                            }, finished: {
                                
                                actor.films = films
                                
                                finished -= 1
                                
                                if finished == 0 {
                                    completion(actors, nil)
                                }
                            }).resume()
                            
                        }
                    }
                }
            } catch let err {
                DispatchQueue.main.async {
                    completion(nil, err)
                }
            }
        })
    }
}
