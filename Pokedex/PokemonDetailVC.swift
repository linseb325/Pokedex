//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Brennan Linse on 4/3/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var idNumberLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var currentEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionImage: UIImageView!
    @IBOutlet weak var nextEvolutionLabel: UILabel!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = pokemon.name.capitalized
        self.idNumberLabel.text = "#\(self.pokemon.idNumber!)"
        
        let currPokeImage = UIImage(named: "\(self.pokemon.idNumber!)")
        self.mainImageView.image = currPokeImage
        self.currentEvolutionImage.image = currPokeImage
        
        self.pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    func updateUI() {
        // Update the UI elements in the details VC
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        typeLabel.text = pokemon.type
        
        
        
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
