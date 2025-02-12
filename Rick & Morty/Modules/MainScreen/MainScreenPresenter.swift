//
//  MainScreenPresenter.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import Foundation

protocol MainScreenPresentationLogic {
    func presentCharacters(response: MainScreenResponse)
}

class MainScreenPresenter: MainScreenPresentationLogic {
    
    weak var viewController: MainScreenDisplayLogic?
    
    func presentCharacters(response: MainScreenResponse) {
        let viewModel = MainScreenViewModel(characters: response.characters)
        viewController?.displayCharacters(viewModel: viewModel)
    }
}

// MARK: - Model
struct MainScreenViewModel {
    let characters: [CharacterModel]
}
