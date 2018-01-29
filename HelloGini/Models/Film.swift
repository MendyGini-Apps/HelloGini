//
//  Film.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

enum FilmKeys: String {
    case title
    case description = "opening_crawl"
    case director
    case producer
    case actorsUrl = "characters"
}

struct Film {
    let title: String
    let description: String
    let director: String
    let producer: String
    let actorsUrl: [String]
    var actors: [Actor]
    
    init(json: [String:Any]) {
        title       = json[FilmKeys.title.rawValue] as? String ?? ""
        description = json[FilmKeys.description.rawValue] as?  String ?? ""
        director    = json[FilmKeys.director.rawValue] as? String ?? ""
        producer    = json[FilmKeys.producer.rawValue] as? String ?? ""
        actorsUrl   = json[FilmKeys.actorsUrl.rawValue] as? [String] ?? []
        actors      = [Actor](repeating: Actor.defaultValue, count: actorsUrl.count)
    }

    mutating func insert(actor: Actor, at index: Int) {
        guard index < actors.count, index >= 0 else { return }
        actors[index] = actor
    }
    
}

extension Film {
    private init() {
        title = ""
        description = ""
        director = ""
        producer = ""
        actorsUrl = []
        actors = []
    }
    static var defaultValue: Film {
        return Film()
    }
    
    var isDefaultValue: Bool {
        return title == ""
    }
}

extension Film: Equatable {
    static func ==(lhs: Film, rhs: Film) -> Bool {
        return lhs.title == rhs.title
    }
}
