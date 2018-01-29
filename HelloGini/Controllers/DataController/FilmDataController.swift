//
//  FilmDataController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 28/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

protocol FilmDataControllerDelegate {
    func filmDownloaded()
    func downloadFinished()
}

protocol FilmDataControllerProtocol {
    var film: Film { get }
    var count: Int { get }
    func actorAt(_ index: Int) -> Actor?
}

class FilmDataController {
    
    private var _film: Film
    
    init(film: Film, delegate: FilmDataControllerDelegate) {
        self._film = film
        self._film.actors = [Actor]()
        
        if let urls = film.actorsUrl?.urls {
            DownloadManager<Actor>(urls: urls, completion: { (actor, index) in
                self._film.actors?.append(actor)
                delegate.filmDownloaded()
            }, finished: {
                delegate.downloadFinished()
            }).resume()
        }
        
    }
    
}

// MARK: - FilmDatacontrollerProtocol
extension FilmDataController: FilmDataControllerProtocol {
    var film: Film {
        return _film
    }
    var count: Int {
        return film.actors?.count ?? 0
    }
    
    func actorAt(_ index: Int) -> Actor? {
        guard index < count && index >= 0 else { return nil }
        return film.actors?[index]
    }
}
