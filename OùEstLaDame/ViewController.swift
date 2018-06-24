//
//  ViewController.swift
//  OùEstLaDame
//
//  Created by Adrien Lefaure on 24/06/2018.
//  Copyright © 2018 Adrien Lefaure. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionViewPlateau: UICollectionView!
    
    var jeu = Game()
    let identifierCell = "CarteCollectionViewCell"
    let nombreDeCartes = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        jeu.initGame(nombreDeCarte: nombreDeCartes)
        
        collectionViewPlateau.dataSource = self
        collectionViewPlateau.delegate = self
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(handlePanGesture))
        collectionViewPlateau.addGestureRecognizer(tapGR)
        tapGR.delegate = self
        
        collectionViewPlateau.register(UINib(nibName: "CarteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifierCell)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionViewPlateau.collectionViewLayout.invalidateLayout()
    }
    
    func rangerLePlateau() {
        for carteCell in collectionViewPlateau.visibleCells {
            if let cell = carteCell as? CarteCollectionViewCell, cell.imageViewDame.image != #imageLiteral(resourceName: "dos") {
                cell.ranger()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jeu.cartes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifierCell, for: indexPath) as! CarteCollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nbCarteParLigneEtColonne = CGFloat(jeu.cartes.count).squareRoot().rounded(.up)
        let spacingLine = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing
        let spacingCell = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing
        let height = (collectionView.frame.height - (spacingCell * (nbCarteParLigneEtColonne - 1))) / nbCarteParLigneEtColonne
        let widht = (collectionView.frame.width - (spacingLine * (nbCarteParLigneEtColonne - 1))) / nbCarteParLigneEtColonne
        return CGSize(width: widht.rounded(.down), height: height.rounded(.down))
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let tupleCell = getCarteCollectionViewCell(gestureRecognizer)
        return tupleCell.1.imageViewDame.image == #imageLiteral(resourceName: "dos")
    }
    
    @objc func handlePanGesture(_ panGestureRecognizer: UITapGestureRecognizer) {
        if panGestureRecognizer.state == .ended {
            print("Touch")
            let tupleCell = getCarteCollectionViewCell(panGestureRecognizer)
            let estDameDeCoeur = jeu.dameDeCoeurEstEn(position: tupleCell.0.row)
            tupleCell.1.tourner(estDameDeCoeur: estDameDeCoeur)
            if estDameDeCoeur {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                    self.rangerLePlateau()
                    self.jeu.initGame(nombreDeCarte: self.nombreDeCartes)
                }
            }
        }
    }
    
    func getCarteCollectionViewCell(_ gestureRecognizer: UIGestureRecognizer) -> (IndexPath ,CarteCollectionViewCell) {
        let locationPoint = gestureRecognizer.location(in: collectionViewPlateau)
        let indexPathOfCell = collectionViewPlateau.indexPathForItem(at: locationPoint)!
        return (indexPathOfCell, collectionViewPlateau.cellForItem(at: indexPathOfCell)! as! CarteCollectionViewCell)
    }
}
