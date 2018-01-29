//
//  PeopleHeaderSection.swift
//  GiniAppsAdaptation
//
//  Created by Menahem Barouk on 22/01/2018.
//  Copyright © 2018 Gini-Apps. All rights reserved.
//

import UIKit

class Section {
    var actor: Actor
    var isCollapse: Bool
    
    init(actor: Actor) {
        self.actor = actor
        isCollapse = true
    }
}

class ActorHeader: UITableViewHeaderFooterView {
    
    static let nib: UINib = {
        let nib = UINib(nibName: "ActorHeader", bundle: nil)
        return nib
    }()
    
    private var section: Section! {
        didSet {
            nameLabel.text = section.actor.name
            genderLabel.text = section.actor.gender
            heightLabel.text = section.actor.height
            
            isCollapse = section.isCollapse
            portraitImageView.image = UIImage(named: section.actor.name) ?? #imageLiteral(resourceName: "noImage")
        }
    }
    
    var isCollapse = true {
        didSet {
            section.isCollapse = isCollapse
            UIView.animate(withDuration: 0.3) {
                self.collapseButton.transform = self.isCollapse ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat.pi*0.5)
            }
            
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var collapseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collapseButton.transform = self.isCollapse ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat.pi*0.5)
        
        roundLayerImage()
    }
    
    private func roundLayerImage() {
        portraitImageView.layer.cornerRadius = min(portraitImageView.bounds.width, portraitImageView.bounds.height)/2
        portraitImageView.layer.masksToBounds = true
    }
    
    func configure(withSection section: Section) {
        self.section = section
    }
    
}
