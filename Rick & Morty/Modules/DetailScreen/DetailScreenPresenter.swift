//
//  DetailScreenPresenter.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 13.02.2025.
//

import UIKit

protocol DetailScreenPresentationLogic {
    func presentCharacterDetails(response: DetailScreenViewModel)
}

class DetailScreenPresenter: DetailScreenPresentationLogic {
    
    weak var viewController: DetailScreenDisplayLogic?
    
    func presentCharacterDetails(response: DetailScreenViewModel) {
        var viewModel = response
        
        loadImage(from: response.imageURL) { image in
            viewModel.image = image
            DispatchQueue.main.async {
                self.viewController?.displayCharacterDetails(viewModel: viewModel)
            }
        }
    }
    
    private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
    }
}
