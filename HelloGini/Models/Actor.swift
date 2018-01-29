//
//  Actor.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

class Actor: Decodable {
    let name: String?
    let height: String?
    let gender: String?
    let mass: String?
    let filmsStr: [String]?
    var films: [Film]?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case height
        case gender
        case mass
        case filmsStr = "films"
        case films = "f"
    }
}

class ActorResult: Decodable {
    let results: [Actor]?
    let count: Int?
}
