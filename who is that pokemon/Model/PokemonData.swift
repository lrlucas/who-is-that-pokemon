//
//  PokemonData.swift
//  who is that pokemon
//
//  Created by Lucas Suarez Blanco on 11/15/22.
//

import Foundation


struct PokemonData : Codable {
    let results: [Result]?
}

struct Result : Codable {
    let name : String
    let url : String
}
