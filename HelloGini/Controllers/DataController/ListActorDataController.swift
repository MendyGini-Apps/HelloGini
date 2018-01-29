//
//  ActorDataController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit


protocol ListActorDataControllerProtocol {
    func actorAt(index: Int) -> Actor
    var items: [Actor] {get}
    var count: Int { get }
}

protocol ListActorDataControllerDelegate: class {
    func downloadFinished()
    func failed(error: Error)
}

class ListActorDataController {
    
    private var actors: [Actor] = []
    
    init(delegate: ListActorDataControllerDelegate) {
        ActorsRequest().getPeople { (actors, error) in
            
            if let error = error {
                delegate.failed(error: error)
            } else if let actors = actors {
                self.actors = actors
                delegate.downloadFinished()
            }
        }
    }
    
}

// MARK: - ListActorDataControllerProtocol
extension ListActorDataController: ListActorDataControllerProtocol {
    func actorAt(index: Int) -> Actor {
        return items[index]
    }
    
    var items: [Actor] {
        return actors
    }
    
    var count: Int {
        return items.count
    }
    
}
