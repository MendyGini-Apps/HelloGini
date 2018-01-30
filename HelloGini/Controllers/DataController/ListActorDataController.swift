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
    func downloadActorFinished()
    func failed(error: Error)
    func downloaded(film: Film, atIndex index: Int, OfActor actor: Actor)
}

class ListActorDataController {
    
    private var actors: [Actor] = []
    private weak var delegate: ListActorDataControllerDelegate?
    
    init(delegate: ListActorDataControllerDelegate) {
        self.delegate = delegate
        ActorsRequest().getActors { (actors, error) in
            if let error = error {
                delegate.failed(error: error)
            } else if let actors = actors {
                self.actors = actors
                delegate.downloadActorFinished()
                self.downloadFilmsOfActor()
            }
        }
    }
    
    private func downloadFilmsOfActor() {
        for actor in actors {
            ActorsRequest.getFilmsFrom(actor: actor, completion: { (film, actor)   in
                if let index = self.actors.index(of: actor) {
                    self.actors[index] = actor
                    self.delegate?.downloaded(film: film, atIndex: index, OfActor: actor)
                }
            })
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
