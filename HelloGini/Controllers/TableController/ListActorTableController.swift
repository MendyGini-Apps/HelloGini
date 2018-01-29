//
//  ListActorTableController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

protocol TableControllerProtocol: UITableViewDataSource, UITableViewDelegate {
    func registerReuseIndentifier(_ identifier: String)
    func refreshData()
}

protocol ListActorTableControllerViewSource {
    var tableView: UITableView { get }
    func didSelectActor(_ actor: Actor)
    func didSelectFilm(_ film: Film)
}

protocol ListActorTableControllerProtocol: TableControllerProtocol {
    func refresh(section: Int, withFilm film: Film)
}

class ListActorTableController: NSObject {
    
    static let indentifier = "indentifier"
    
    let data: ListActorDataController
    let viewSource: ListActorTableControllerViewSource
    
    private var actorHeader: [Section] = []
    
    
    init(viewSource: ListActorTableControllerViewSource, dataDelegate: ListActorDataControllerDelegate) {
        data = ListActorDataController(delegate: dataDelegate)
        self.viewSource = viewSource
        super.init()
        
        registerReuseIndentifier(ListActorTableController.indentifier)
    }


}

// MARK: - TableControllerProtocol
extension ListActorTableController: ListActorTableControllerProtocol {
    func registerReuseIndentifier(_ identifier: String) {
        let tableView = viewSource.tableView
        tableView.register(FilmTableViewCell.nib, forCellReuseIdentifier: identifier)
        tableView.register(ActorHeader.nib, forHeaderFooterViewReuseIdentifier: identifier)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = 140
    }
    
    func refreshData() {
        actorHeader = data.items.sections
        viewSource.tableView.reloadData()
    }
    
    func refresh(section: Int, withFilm film: Film) {
        guard let index = actorHeader[section].actor.insert(film: film, at: nil) else { return }
        let indexPath = IndexPath(row: index, section: section)
        if viewSource.tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
            viewSource.tableView.beginUpdates()
            viewSource.tableView.reloadRows(at: [indexPath], with: .none)
            viewSource.tableView.endUpdates()
        }
    }
}

// MARK: - UITableViewDataSource
extension ListActorTableController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return actorHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if actorHeader[section].isCollapse {
            return 0
        }
        return actorHeader[section].actor.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListActorTableController.indentifier, for: indexPath)  as! FilmTableViewCell
        cell.configure(whiteFilm: actorHeader[indexPath.section].actor.films[indexPath.row])
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ListActorTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListActorTableController.indentifier) as? ActorHeader else {
            return nil
        }
        header.collapseButton.tag = section
        header.collapseButton.addTarget(self, action: #selector(handleExpandClose(_:)), for: .touchUpInside)
        
        header.configure(withSection: actorHeader[section])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handlePresentPerson(_:)))
        header.addGestureRecognizer(tapGesture)
        tapGesture.view?.tag = section
        
        return header
    }
    
    @objc
    private func handlePresentPerson(_ gesture: UIGestureRecognizer) {
        if let section = gesture.view?.tag {
            let actor = actorHeader[section].actor
            viewSource.didSelectActor(actor)
        }
    }
    
    @objc
    private func handleExpandClose(_ button: UIButton) {
        let section = button.tag
        let films = data.actorAt(index: section).films
        
        let header = viewSource.tableView.headerView(forSection: section) as! ActorHeader
        
        let isCollapse = header.isCollapse
        header.isCollapse = !isCollapse
        
        var indexPaths = [IndexPath]()
        for row in films.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        viewSource.tableView.beginUpdates()
        if isCollapse {
            viewSource.tableView.insertRows(at: indexPaths, with: .fade)
        } else {
            viewSource.tableView.deleteRows(at: indexPaths, with: .fade)
        }
        viewSource.tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let film = actorHeader[indexPath.section].actor.films[indexPath.row]
        viewSource.didSelectFilm(film)
    }
}






















