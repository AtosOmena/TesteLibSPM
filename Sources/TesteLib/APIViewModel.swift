//
//  APIViewModel.swift
//  Pokedex
//
//  Created by Atos Brito Omena on 03/06/25.
//

import Foundation

class APIViewModel: ObservableObject, Observable {

    private let address: String = "https://pokeapi.co/api/v2/"
    
    private var pageSize: Int = 20
    private var atualPage: Int = 0
    
    private var totalItems: Int?
    
    func isFirstPage() -> Bool {
        return atualPage == 0
    }
    
    func isLastPage() -> Bool {
        guard let totalItems = totalItems else { return false }
        return (atualPage * pageSize) >= totalItems
    }
    
    // Solicita um pokemon na API dado um nome
    func getPokemonByName(name: String) async throws -> Pokemon {
        
        let urlString = "\(address)pokemon/\(name)"
        
        guard let url = URL(string: urlString) else {
            throw PokemonError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokemonError.invalidResponse
        }
        
        do{
            let decoder = JSONDecoder()
            let pokemon = try decoder.decode(Pokemon.self, from: data)
            
            return pokemon
        }catch {
            throw PokemonError.unexpectedError
        }
    }
    
    // Solicita uma lista contendo alguns pokemons
    func getPokemonPage() async throws -> Page<PokemonIndex> {
        
        let urlString = "\(address)pokemon?offset=\(atualPage*pageSize)&limit=\(pageSize)"
        
        guard let url = URL(string: urlString) else {
            throw PokemonError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PokemonError.invalidResponse
        }
        
        atualPage += 1
        
        do{
            let decoder = JSONDecoder()
            let pokemons = try decoder.decode(Page<PokemonIndex>.self, from: data)
            
            totalItems = pokemons.count
            
            return pokemons
        }catch {
            throw PokemonError.unexpectedError
        }
    }
}

enum PokemonError: Error {
    case invalidURL
    case invalidResponse
    case unexpectedError
}
