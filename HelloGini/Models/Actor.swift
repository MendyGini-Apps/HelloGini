//
//  Actor.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

enum ActorsKeys: String {
    case name
    case height
    case gender
    case mass
    case films
}

struct Actor {
    let name: String
    let height: String
    let gender: String
    let mass: String
    let filmsStr: [String]
    var films: [Film]
    
    init(json: [String:Any]) {
        name        = json[ActorsKeys.name.rawValue] as? String ?? ""
        height      = json[ActorsKeys.height.rawValue] as? String ?? ""
        gender      = json[ActorsKeys.gender.rawValue] as? String ?? ""
        mass        = json[ActorsKeys.mass.rawValue] as? String ?? ""
        filmsStr    = json[ActorsKeys.films.rawValue] as? [String] ?? []
        films       = [Film](repeating: Film.defaultValue, count: filmsStr.count)
    }
    
    @discardableResult
    mutating func insert(film: Film, at index: Int?) -> Int? {
        if index == nil {
            if let index = films.index(where: {$0.isDefaultValue}) {
                films[index] = film
                return index
            }
        } else {
            guard index! < films.count, index! >= 0 else { return nil }
            films[index!] = film
        }
        return nil
    }
}

extension Actor {
    private init() {
        name = ""
        height = ""
        gender = ""
        mass = ""
        filmsStr = []
        films = []
    }
    static var defaultValue: Actor {
        return Actor()
    }
    
    var isDefaultValue: Bool {
        return name == ""
    }
}

extension Actor: Equatable {
    static func ==(lhs: Actor, rhs: Actor) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Actor {
    static func getActorsFromJsonArray(_ jsonArray: [[String:Any]]) -> [Actor] {
        var actors = [Actor]()
        for actorJson in jsonArray {
            let actor = Actor(json: actorJson)
            
            actors.append(actor)
        }
        return actors
    }
}
