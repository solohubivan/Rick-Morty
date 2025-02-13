//
//  CharacterModel.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import Foundation
import UIKit

struct CharacterModel: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Origin
    let location: Location
    let episode: [String]
    let imagePicture: Data?
}

struct Origin: Decodable {
    let name: String
}

struct Location: Decodable {
    let name: String
}
