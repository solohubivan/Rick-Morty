//
//  DetailScreenViewController.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import UIKit

protocol DetailScreenDisplayLogic: AnyObject {
    func displayCharacterDetails(viewModel: DetailScreenViewModel)
}

class DetailScreenViewController: UIViewController {
    
    @IBOutlet weak private var characterNameLabel: UILabel!
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var aliveSpeciesLabel: UILabel!
    @IBOutlet weak private var aliveStatusView: UIView!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var originLabel: UILabel!
    @IBOutlet weak private var charactersLastLocationLabel: UILabel!
    @IBOutlet weak private var participatedEpisodesLabel: UILabel!
    
    private var interactor: DetailScreenBusinessLogic?
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCleanSwift()
        
        if let character = character {
            interactor?.fetchCharacterDetails(character: character)
        }
    }
    
    // MARK: - Private methods
    private func setupCleanSwift() {
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        self.interactor = interactor
    }
}

// MARK: - Display Logic
extension DetailScreenViewController: DetailScreenDisplayLogic {
    func displayCharacterDetails(viewModel: DetailScreenViewModel) {
        characterNameLabel.text = viewModel.name
        aliveSpeciesLabel.text = viewModel.aliveSpecies
        genderLabel.text = viewModel.gender
        originLabel.text = viewModel.origin
        charactersLastLocationLabel.text = viewModel.lastLocation
        participatedEpisodesLabel.text = viewModel.episodesCount
        aliveStatusView.backgroundColor = viewModel.statusColor
        characterImageView.image = viewModel.image
    }
}

// MARK: - Setup UI
extension DetailScreenViewController {
    
    private func setupUI() {
        setupNavigationBar()
        setupCharacterNameLabel()
        setupCharacterImageView()
        setupAliveSpeciesLabel()
        setupGenderLabel()
        setupOriginLabel()
        setupCharactersLastLocationLabel()
        setupParticipatedEpisodesLabel()
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupCharacterNameLabel() {
        characterNameLabel.font = UIFont(name: AppConstants.Fonts.openSansBold, size: 28)
        characterNameLabel.textColor = .darkBlueFontColor
    }
    
    private func setupCharacterImageView() {
        characterImageView.layer.cornerRadius = 10
    }
    
    private func setupAliveSpeciesLabel() {
        aliveSpeciesLabel.textColor = .darkBlueFontColor
        aliveSpeciesLabel.font = UIFont(name: AppConstants.Fonts.openSansSemibold, size: 20)
    }
    
    private func setupGenderLabel() {
        genderLabel.textColor = .darkBlueFontColor
        genderLabel.font = UIFont(name: AppConstants.Fonts.openSansSemibold, size: 18)
    }
    
    private func setupOriginLabel() {
        originLabel.textColor = .darkBlueFontColor
        originLabel.font = UIFont(name: AppConstants.Fonts.openSansSemibold, size: 18)
    }
    
    private func setupCharactersLastLocationLabel() {
        charactersLastLocationLabel.textColor = .darkBlueFontColor
        charactersLastLocationLabel.font = UIFont(name: AppConstants.Fonts.openSansSemibold, size: 18)
    }
    
    private func setupParticipatedEpisodesLabel() {
        participatedEpisodesLabel.textColor = .darkBlueFontColor
        participatedEpisodesLabel.font = UIFont(name: AppConstants.Fonts.openSansSemibold, size: 18)
    }
}
