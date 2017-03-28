//
//  MainScreenVC.Swift
//  Pokedex
//
//  Created by Brennan Linse on 3/21/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import UIKit
import AVFoundation

class MainScreenVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.searchBar.delegate = self
        
        self.parsePokemonCSV()
        self.initAudio()
        self.searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    // Parse through CSV file for Pokemon data
    func parsePokemonCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows {
                print(row)
            }
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let aPoke = Pokemon(name: name, idNum: pokeID)
                self.pokemonArray.append(aPoke)
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            self.musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            self.musicPlayer.prepareToPlay()
            self.musicPlayer.numberOfLoops = -1
            self.musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        
        if self.musicPlayer.isPlaying {
            self.musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            self.musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    
    // COLLECTION VIEW METHODS:
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            // Configure the cell
            
            let aPoke: Pokemon!
            if self.inSearchMode {
                aPoke = self.filteredPokemon[indexPath.row]
            } else {
                aPoke = self.pokemonArray[indexPath.row]
            }
            
            cell.configureCell(aPoke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // What happens when we select a cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.inSearchMode {
            return self.filteredPokemon.count
        } else {
            return self.pokemonArray.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil || searchBar.text == "") {
            inSearchMode = false
            self.collectionView.reloadData()
            self.view.endEditing(true)
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            self.filteredPokemon = self.pokemonArray.filter({$0.name.range(of: lower) != nil})
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    
    
    
}

