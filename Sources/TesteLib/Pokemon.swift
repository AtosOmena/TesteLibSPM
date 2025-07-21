//
//  Pokemon.swift
//  Pokedex
//
//  Created by Atos Brito Omena on 03/06/25.
//

public class Pokemon: Codable, Identifiable{
    
    public let id: Int
    public let name: String
    
    public let sprites: Sprites
}

public class PokemonIndex: Codable, Identifiable{
    public let name: String
    public let url: String
}

public class Sprites: Codable{
    public let front_default: String
}

public class Page<T: Codable>: Codable, Identifiable{
    public let count: Int
    public let next: String
    public let previous: String?
    public let results: [T]
}
