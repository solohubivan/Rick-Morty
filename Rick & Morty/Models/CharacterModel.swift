//
//  CharacterModel.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import Foundation

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Origin
    let episode: [String]
}

struct Origin: Decodable {
    let name: String
}
