//
//  CarteCollectionViewCell.swift
//  OùEstLaDame
//
//  Created by Adrien Lefaure on 24/06/2018.
//  Copyright © 2018 Adrien Lefaure. All rights reserved.
//

import UIKit

class CarteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewDame: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func tourner(estDameDeCoeur: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            if estDameDeCoeur {
                self.self.imageViewDame.image = #imageLiteral(resourceName: "coeur")
            } else {
                self.self.imageViewDame.image = #imageLiteral(resourceName: "pique")
            }
        })
    }
    
    func ranger() {
        UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromRight, animations: {
            self.self.imageViewDame.image = #imageLiteral(resourceName: "dos")
        })
    }
}
