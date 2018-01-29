//
//  Film.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

class Film: Decodable {
    let title: String?
    let description: String?
    let director: String?
    let producer: String?
    let actorsUrl: [String]?
    
    var actors: [Actor]?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case director
        case producer
        case description = "opening_crawl"
        case actorsUrl = "characters"
        case actors = "a"
    }
}
