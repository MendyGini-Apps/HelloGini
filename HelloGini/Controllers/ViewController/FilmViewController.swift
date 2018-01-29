//
//  FilmViewController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class FilmViewController: UIViewController {

    class func instantiateFilmVC(withFilm film: Film) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let filmVC = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as! FilmViewController
        filmVC.film = film
        return filmVC
    }
    
    var film: Film!
    var tableController: FilmTableController!
    
    @IBOutlet weak var filmsTableView: UITableView! {
        didSet {
            tableController = FilmTableController(viewSource: self, data: FilmDataController(film: film, delegate: self))
            filmsTableView.dataSource = tableController
            filmsTableView.delegate = tableController
        }
    }
    
}

// MARK: - View Life Cycle
extension FilmViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Actors"
        navigationItem.prompt = film.title
        
    }
}

// MARK: - FilmTableControllerViewSource
extension FilmViewController: FilmTableControllerViewSource {
    var tableView: UITableView {
        return filmsTableView
    }
    
    
}

// MARK: - FilmDataControllerDelegate
extension FilmViewController: FilmDataControllerDelegate {
    func filmDownloaded() {
        tableController.refreshData()
    }
    
    func downloadFinished() {
        
    }
}
