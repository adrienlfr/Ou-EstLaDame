//
//  Game.swift
//  OùEstLaDame
//
//  Created by Adrien Lefaure on 24/06/2018.
//  Copyright © 2018 Adrien Lefaure. All rights reserved.
//

import Foundation

struct Game {
    var cartes = [Carte]()
    
    mutating func initGame(nombreDeCarte : Int) {
        cartes.removeAll()
        let positionDameDeCoeur = arc4random_uniform(UInt32(nombreDeCarte))
        for i in 0..<nombreDeCarte {
            if (i == positionDameDeCoeur) {
                self.cartes.append(Carte.dameDeCoeur)
            } else {
                self.cartes.append(Carte.dameDePique)
            }
        }
    }
    
    func dameDeCoeurEstEn(position : Int) -> Bool {
        return cartes[position] == Carte.dameDeCoeur
    }
}
