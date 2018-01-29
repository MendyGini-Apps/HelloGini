//
//  FilmsRequest
//  HelloGini
//
//  Created by Menahem Barouk on 29/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation
import Alamofire

class FilmRequest {
    
    class func getActorsFrom(film: Film, completion: @escaping (_ actor: Actor, _ inIndex: Int, _ ofFilm: Film) -> Void) {
        var film = film
        
        
        for url in film.actorsUrl.urls {
            
            HTTPRequest(url: url).fetchResult(completion: { (result, response, error) in
                
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                
                
                guard let json = result,
                    let urlResponse = response?.url,
                    let index = film.actorsUrl.index(of: urlResponse.absoluteString) else { return }
                
                let actor = Actor(json: json)
                film.insert(actor: actor, at: index)
                completion(actor, index, film)
            })
            
        }
        
    }
    
}
