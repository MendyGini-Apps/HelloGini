//
//  FilmTableController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 28/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

protocol FilmTableControllerViewSource {
    var tableView: UITableView { get }
}

class FilmTableController: NSObject {
    

    static let identifier = "identifier"
    
    let viewSource: FilmTableControllerViewSource
    let data: FilmDataController
    
    init(viewSource: FilmTableControllerViewSource, data: FilmDataController) {
        self.viewSource = viewSource
        self.data = data
        super.init()
        registerReuseIndentifier(FilmTableController.identifier)
    }
    
}

// MARK: - Table Controller Protocol
extension FilmTableController: TableControllerProtocol {
    func registerReuseIndentifier(_ identifier: String) {
        viewSource.tableView.register(ActorCell.nib, forCellReuseIdentifier: identifier)
    }
    
    func refreshData() {
        viewSource.tableView.reloadData()
    }
}

// MARK: - UITableView DataSource
extension FilmTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableController.identifier, for: indexPath) as! ActorCell
        let actor = data.actorAt(indexPath.row)
        cell.configure(withName: actor?.name, gender: actor?.gender, height: actor?.height)
        
        return cell
    }
}
