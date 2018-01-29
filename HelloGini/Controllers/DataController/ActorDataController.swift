//
//  ActorDataController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 28/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

protocol ActorDataControllerProtocol {
    func filmsAt(index: Int) -> Film?
    var items: [Film] {get}
    var count: Int { get }
    var actor: Actor { get }
}

class ActorDataController {
    
    private let _actor: Actor
    
    init(actor: Actor) {
        self._actor = actor
    }
    
}

// MARK: - ActorDatacontrollerProtocol
extension ActorDataController: ActorDataControllerProtocol {

    var actor: Actor {
        return _actor
    }
    
    var items: [Film] {
        return actor.films ?? []
    }
    
    var count: Int {
        return items.count
    }
    
    func filmsAt(index: Int) -> Film? {
        guard index < count && index >= 0 else { return nil }
        return items[index]
    }
}
