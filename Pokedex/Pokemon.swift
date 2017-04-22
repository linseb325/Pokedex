//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brennan Linse on 3/23/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import Foundation
import Alamofire


class Pokemon {
    
    private var _name: String!
    private var _idNumber: Int!
    private var _description: String!
    private var _type: String!
    private var _attack: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLevel: String!
    private var _URL: String!
    
    
    var name: String! {
        return self._name
    }
    
    var idNumber: Int! {
        return self._idNumber
    }
    
    var description: String {
        if self._description == nil {
            self._description = ""
        }
        return self._description
    }
    
    var type: String {
        if self._type == nil {
            self._type = ""
        }
        return self._type
    }
    
    var attack: String {
        if self._attack == nil {
            self._attack = ""
        }
        return self._attack
    }
    
    var defense: String {
        if self._defense == nil {
            self._defense = ""
        }
        return self._defense
    }
    
    var height: String {
        if self._height == nil {
            self._height = ""
        }
        return self._height
    }
    
    var weight: String {
        if self._weight == nil {
            self._weight = ""
        }
        return self._weight
    }
    
    var nextEvolutionText: String {
        if self._nextEvolutionText == nil {
            self._nextEvolutionText = ""
        }
        return self._nextEvolutionText
    }
    
    var nextEvolutionName: String {
        if self._nextEvolutionName == nil {
            self._nextEvolutionName = ""
        }
        return self._nextEvolutionName
    }
    
    var nextEvolutionID: String {
        if self._nextEvolutionID == nil {
            self._nextEvolutionID = ""
        }
        return self._nextEvolutionID
    }
    
    var nextEvolutionLevel: String {
        if self._nextEvolutionLevel == nil {
            self._nextEvolutionLevel = ""
        }
        return self._nextEvolutionLevel
    }
    
    
    init(name: String, idNum: Int) {
        self._name = name
        self._idNumber = idNum
        
        self._URL = "http://pokeapi.co/api/v1/pokemon/\(idNum)/"
    }
    
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        
        Alamofire.request(self._URL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, Any> {
                
                // Get height, weight, attack, and defense
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                // Get Pokemon type
                if let typeArray = dict["types"] as? [Dictionary<String, String>] , typeArray.count > 0 {
                    var typeString = ""
                    for currIndex in (0..<typeArray.count).reversed() {
                        if let type = typeArray[currIndex]["name"] {
                            typeString.append("\(type.capitalized)/")
                        }
                        if currIndex == 0 {
                            typeString.characters.removeLast()
                        }
                    }
                    self._type = typeString
                } else {
                    self._type = ""
                }
                
                // Get description
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] , descArray.count > 0 {
                    if let descURL = descArray[0]["resource_uri"] {
                        
                        Alamofire.request("http://pokeapi.co\(descURL)").responseJSON { response in
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                if let description = descDict["description"] as? String {
                                    var fixedDescription = description.replacingOccurrences(of: "POKMON", with: "POKÉMON")
                                    fixedDescription = fixedDescription.replacingOccurrences(of: "Pokmon", with: "Pokémon")
                                    self._description = fixedDescription
                                }
                            }
                            completed()
                        }
                        
                    }
                } else {
                    self._description = ""
                }
                
                // Get evolution information
                if let evoArray = dict["evolutions"] as? [Dictionary<String, Any>] , evoArray.count > 0 {
                    if let nextEvoName = evoArray[0]["to"] as? String {
                        // We don't care about mega-evolutions
                        if nextEvoName.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvoName
                            if let uri = evoArray[0]["resource_uri"] as? String {
                                let newURI = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newURI.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionID = nextEvoID
                                
                                if let levelExists = evoArray[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(levelExists)"
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                } else {
                    self._nextEvolutionText = ""
                }
                
                
            }
            completed()
            
            
            
        }
        
    }
    
}
