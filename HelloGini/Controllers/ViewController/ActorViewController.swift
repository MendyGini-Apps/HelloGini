//
//  ActorViewController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class ActorViewController: UIViewController {

    class func instantiateActorVC(withActor actor: Actor) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let actorVC = storyboard.instantiateViewController(withIdentifier: "ActorViewController") as! ActorViewController
        
        actorVC.actor = actor
        
        return actorVC
    }
    
    private var tableController: ActorTableController!
    var actor: Actor!
    
    @IBOutlet weak var detailsFilmTableView: UITableView! {
        didSet {
            tableController = ActorTableController(viewSource: self, data: ActorDataController(actor: actor))
            detailsFilmTableView.dataSource = tableController
            detailsFilmTableView.delegate = tableController
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension ActorTableControllerViewSource
extension ActorViewController: ActorTableControllerViewSource {
    var tableView: UITableView {
        return detailsFilmTableView
    }
    
    func handleDismiss() {
        dismiss(animated: true)
    }
}
