//
//  ParallaxHeader.swift
//  HelloGini
//
//  Created by Menahem Barouk on 25/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class ParallaxHeader: UITableViewHeaderFooterView {

    static let nib: UINib = {
        let nib = UINib(nibName: "ParallaxHeader", bundle: nil)
        return nib
    }()

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heightBaseContainerConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomBaseContainerConstraint: NSLayoutConstraint!

    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    func configure(withActor actor: Actor) {
        nameLabel.text = actor.name
        genderLabel.text = actor.gender
        heightLabel.text = actor.height
        
        portraitImageView.image = UIImage(named: actor.name ?? "") ?? #imageLiteral(resourceName: "noImage")
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        containerView.clipsToBounds = offsetY >= 0
        bottomBaseContainerConstraint.constant = offsetY <= 0 ? 0 : offsetY/2
        heightBaseContainerConstraint.constant = max(-offsetY, scrollView.contentInset.top)
    }

}
