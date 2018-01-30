//
//  Array+urls.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 23/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

extension Array where Element == String {

    var urls: [URL] {
        var urls = [URL]()
        
        self.forEach{
            if let url = URL(string: $0) {
                urls.append(url)
            }
        }
        
        return urls
    }
}

extension Array where Element == Actor {
    var sections: [Section] {
        var sections = [Section]()
        self.forEach{
            sections.append(Section(actor: $0))
        }
        return sections
    }
}

