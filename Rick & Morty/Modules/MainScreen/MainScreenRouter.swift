//
//  MainScreenRouter.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 13.02.2025.
//

import UIKit

protocol MainScreenRoutingLogic {
    func routeToDetailScreen(from viewController: UIViewController, with character: CharacterModel)
}

class MainScreenRouter: MainScreenRoutingLogic {
    func routeToDetailScreen(from viewController: UIViewController, with character: CharacterModel) {
        let detailVC = DetailScreenViewController()
        detailVC.character = character
        viewController.navigationController?.pushViewController(detailVC, animated: true)
    }
}
