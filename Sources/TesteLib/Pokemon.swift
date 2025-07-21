//
//  Pokemon.swift
//  Pokedex
//
//  Created by Atos Brito Omena on 03/06/25.
//

class Pokemon: Codable, Identifiable{
    
    let id: Int
    let name: String
    
    let sprites: Sprites
}

class PokemonIndex: Codable, Identifiable{
    let name: String
    let url: String
}

class Sprites: Codable{
    let front_default: String
}

class Page<T: Codable>: Codable, Identifiable{
    let count: Int
    let next: String
    let previous: String?
    let results: [T]
}
