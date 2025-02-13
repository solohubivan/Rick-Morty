//
//  MainScreenInteractor.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import Foundation

protocol MainScreenBusinessLogic {
    func checkConnectionAndGetData()
    func fetchCharacters()
}

class MainScreenInteractor: MainScreenBusinessLogic {
    
    var presenter: MainScreenPresentationLogic?
    
    private var nextPageURL: String? = "https://rickandmortyapi.com/api/character"
    private var isLoading = false
    
    func checkConnectionAndGetData() {
        if NetworkMonitor.shared.connectionMode == .online {
            fetchCharacters()
        } else {
            let cachedCharacters = CacheManager.shared.loadAllFromCache()
            let responseModel = MainScreenResponse(characters: cachedCharacters, nextPageURL: nil)
            presenter?.presentCharacters(response: responseModel)
        }
    }
    
    func fetchCharacters() {
        guard let urlString = nextPageURL, let url = URL(string: urlString), !isLoading else { return }
        isLoading = true
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                self?.isLoading = false
                return
            }

            do {
                let response = try JSONDecoder().decode(RickAndMortyResponse.self, from: data)
                DispatchQueue.main.async {
                    let responseModel = MainScreenResponse(characters: response.results, nextPageURL: response.info.next)
                    self.nextPageURL = response.info.next
                    self.presenter?.presentCharacters(response: responseModel)
                    
                    CacheManager.shared.saveAllToCache(response.results)
                    
                    self.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                self.isLoading = false
            }
        }.resume()
    }
}

// MARK: - Model
struct MainScreenResponse {
    let characters: [CharacterModel]
    let nextPageURL: String?
}
