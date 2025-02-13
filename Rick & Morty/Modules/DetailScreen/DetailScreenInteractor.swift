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
        let image = character.imagePicture != nil ? UIImage(data: character.imagePicture!) : nil
            
        let viewModel = DetailScreenViewModel(
            name: character.name,
            aliveSpecies: "\(character.status.capitalized) - \(character.species.capitalized)",
            gender: "\(AppConstants.CharacterParameters.gender): \(character.gender)",
            origin: "\(AppConstants.CharacterParameters.origin): \(character.origin.name)",
            lastLocation: "\(AppConstants.CharacterParameters.lastLocation): \(character.location.name)",
            episodesCount: "\(AppConstants.CharacterParameters.participatedEpisodesAmount): \(character.episode.count)",
            statusColor: getStatusColor(for: character.status),
            imageURL: character.image,
            image: image
        )
            
        presenter?.presentCharacterDetails(response: viewModel)
    }
    
    private func getStatusColor(for status: String) -> UIColor {
        switch status.lowercased() {
        case "\(AppConstants.CharacterParameters.alive)":
            return .systemGreen
        case "\(AppConstants.CharacterParameters.dead)":
            return .systemRed
        default:
            return .systemGray
        }
    }
}
