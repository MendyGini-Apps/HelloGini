//
//  DownloadManager.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 23/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import Foundation

class DownloadManager<T: Decodable> {
    
    typealias DownloadCompletion = (_ model: T, _ index: Int) -> Void
    typealias DownloadFinished = () -> Void
    
    private let urls: [URL]
    private let completion: DownloadCompletion
    private let finished: DownloadFinished
    
    init(urls: [URL], completion: @escaping DownloadCompletion, finished: @escaping DownloadFinished) {
        self.urls = urls
        self.completion = completion
        self.finished = finished
    }
    
    func resume() {
        fetchResult()
    }
    
    private func fetchResult() {
        var finished = urls.count
        for url in urls {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let data = data {
                    if let decodedObject = try? JSONDecoder().decode(T.self, from: data) {
                        
                        if let requestedUrl = response?.url,
                            let index = self.urls.index(of: requestedUrl) {
                            
                            finished -= 1
                            
                            DispatchQueue.main.async {
                                self.completion(decodedObject, index)
                                if finished == 0 {
                                    self.finished()
                                }
                            }
                        }
                    }
                }
            }).resume()
        }
    }
}



