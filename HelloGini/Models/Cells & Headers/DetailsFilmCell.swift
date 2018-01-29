//
//  FilmCell.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 23/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class DetailsFilmCell: UITableViewCell {
    
    static let nib: UINib = {
        let nib = UINib(nibName: "DetailsFilmCell", bundle: nil)
        return nib
    }()
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.isHidden = true
    }
    
    func configure(with film: Film?, isReady: Bool) {
        if isReady {
            titleLabel.text = film?.title
            directorLabel.text = film?.director
            producerLabel.text = film?.producer
            descriptionLabel.text = film?.description
        }
        containerView.isHidden = !isReady
        indicator.isHidden = isReady
    }
    
}
