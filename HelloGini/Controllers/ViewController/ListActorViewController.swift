//
//  ListActorViewController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class ListActorViewController: UIViewController {

    @IBOutlet weak var actorsTableView: UITableView! {
        didSet {
            tableController = ListActorTableController(viewSource: self, dataDelegate: self)
            actorsTableView.delegate = tableController
            actorsTableView.dataSource = tableController
            actorsTableView.isHidden = true
        }
    }
    @IBOutlet weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.hidesWhenStopped = true
            indicator.isHidden = false
            indicator.startAnimating()
        }
    }
    
    private var tableController: ListActorTableControllerProtocol!
}


// MARK: - List Actor DataController Delegate
extension ListActorViewController: ListActorDataControllerDelegate {
    func downloaded(film: Film, atIndex index: Int, OfActor actor: Actor) {
        tableController.refresh(section: index, withFilm: film)
    }
    
    func downloadActorFinished() {
        indicator.stopAnimating()
        actorsTableView.isHidden = false
        tableController.refreshData()
    }
    
    func failed(error: Error) {
        showErrorMsg(title: "Error", msg: error.localizedDescription)
    }
}

// MARK: - ListActorTableControllerViewSource
extension ListActorViewController: ListActorTableControllerViewSource {
    func didSelectFilm(_ film: Film) {
        let filmVC = FilmViewController.instantiateFilmVC(withFilm: film)
        navigationController?.pushViewController(filmVC, animated: true)
    }
    
    func didSelectActor(_ actor: Actor) {
        let actorVC = ActorViewController.instantiateActorVC(withActor: actor)
        present(actorVC, animated: true)
    }

    var tableView: UITableView {
        return actorsTableView
    }
    
    
}
