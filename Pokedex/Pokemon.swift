//
//  Pokemon.swift
//  Pokedex
//
//  Created by Brennan Linse on 3/23/17.
//  Copyright © 2017 Brennan Linse. All rights reserved.
//

import Foundation


class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _idNumber: Int!
    
    var name: String! {
        return self._name
    }
    
    var idNumber: Int! {
        return self._idNumber
    }
    
    init(name: String, idNum: Int) {
        self._name = name
        self._idNumber = idNum
    }
    
}
