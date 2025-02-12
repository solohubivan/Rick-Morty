//
//  RickAndMortyResponse.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

struct RickAndMortyResponse: Decodable {
    let info: Info
    let results: [CharacterModel]
}

struct Info: Decodable {
    let next: String?
}
