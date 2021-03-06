//
//  PokeCell.swift
//  Pokedex
//
//  Created by Brennan Linse on 3/23/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        self.nameLabel.text = self.pokemon.name.capitalized
        self.imageView.image = UIImage(named: "\(self.pokemon.idNumber!)")
    }
    
    // For styling the custom cell (rounded edges)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
    }
    
    
    
    
    
}
