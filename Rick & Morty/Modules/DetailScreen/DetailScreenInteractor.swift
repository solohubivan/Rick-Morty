//
//  DetailScreenInteractor.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 13.02.2025.
//

import UIKit

protocol DetailScreenBusinessLogic {
    func fetchCharacterDetails(character: CharacterModel)
}

class DetailScreenInteractor: DetailScreenBusinessLogic {
    
    var presenter: DetailScreenPresentationLogic?
    
    func fetchCharacterDetails(character: CharacterModel) {
        let viewModel = DetailScreenViewModel(
            name: character.name,
            aliveSpecies: "\(character.status.capitalized) - \(character.species.capitalized)",
            gender: "Gender: \(character.gender)",
            origin: "Origin: \(character.origin.name)",
            lastLocation: "Last location: \(character.location.name)",
            episodesCount: "Participated episodes amount: \(character.episode.count)",
            statusColor: getStatusColor(for: character.status),
            imageURL: character.image
        )
        presenter?.presentCharacterDetails(response: viewModel)
    }
    
    private func getStatusColor(for status: String) -> UIColor {
        switch status.lowercased() {
        case "alive":
            return .systemGreen
        case "dead":
            return .systemRed
        default:
            return .systemGray
        }
    }
}
