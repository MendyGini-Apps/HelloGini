
//  ActorTableController.swift
//  HelloGini
//
//  Created by Menahem Barouk on 28/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

protocol ActorTableControllerViewSource {
    var tableView: UITableView { get }
    func handleDismiss()
}

class ActorTableController: NSObject {
    
    static let identifier = "identifier"

    let viewSource: ActorTableControllerViewSource
    let data: ActorDataController
    
    init(viewSource: ActorTableControllerViewSource, data: ActorDataController) {
        self.viewSource = viewSource
        self.data = data
        super.init()
        
        registerReuseIndentifier(ActorTableController.identifier)
    }
    

}

// MARK: - TableControllerProtocol
extension ActorTableController: TableControllerProtocol {
    func registerReuseIndentifier(_ indentifier: String) {
        let tableView = viewSource.tableView
        tableView.register(DetailsFilmCell.nib, forCellReuseIdentifier: indentifier)
        tableView.register(ParallaxHeader.nib, forHeaderFooterViewReuseIdentifier: indentifier)
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    func refreshData() {
        viewSource.tableView.reloadData()
    }
}

// MARK: - UITableViewdataSource
extension ActorTableController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActorTableController.identifier, for: indexPath) as! DetailsFilmCell
        cell.configure(with: data.filmsAt(index: indexPath.row), isReady: true)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ActorTableController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ActorTableController.identifier) as? ParallaxHeader else {
            return nil
        }
        
        headerView.configure(withActor: data.actor)
        
        headerView.cancelButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        
        return headerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let headerView = viewSource.tableView.headerView(forSection: 0) as? ParallaxHeader {
            headerView.scrollViewDidScroll(scrollView)
        }
        
        if scrollView.contentOffset.y < -150 {
            dismissAction()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    
    
    @objc
    func dismissAction() {
        viewSource.handleDismiss()
    }
}

