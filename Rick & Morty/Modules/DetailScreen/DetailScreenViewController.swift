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
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var aliveSpeciesLabel: UILabel!
    @IBOutlet weak var aliveStatusView: UIView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var charactersLastLocationLabel: UILabel!
    @IBOutlet weak var participatedEpisodesLabel: UILabel!
    
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
        characterNameLabel.font = UIFont(name: "OpenSans-Bold", size: 28)
        characterNameLabel.textColor = UIColor(red: 0.0118, green: 0.1451, blue: 0.2549, alpha: 1.0)
    }
    
    private func setupCharacterImageView() {
        characterImageView.layer.cornerRadius = 10
    }
    
    private func setupAliveSpeciesLabel() {
        aliveSpeciesLabel.textColor = UIColor(red: 0.0118, green: 0.1451, blue: 0.2549, alpha: 1.0)
        aliveSpeciesLabel.font = UIFont(name: "OpenSans-Semibold", size: 20)
    }
    
    private func setupGenderLabel() {
        genderLabel.textColor = UIColor(red: 0.0118, green: 0.1451, blue: 0.2549, alpha: 1.0)
        genderLabel.font = UIFont(name: "OpenSans-Semibold", size: 18)
    }
    
    private func setupOriginLabel() {
        originLabel.textColor = UIColor(red: 0.0118, green: 0.1451, blue: 0.2549, alpha: 1.0)
        originLabel.font = UIFont(name: "OpenSans-Semibold", size: 18)
    }
    
    private func setupCharactersLastLocationLabel() {
        charactersLastLocationLabel.textColor = UIColor(red: 0.0118, green: 0.1451, blue: 0.2549, alpha: 1.0)
        charactersLastLocationLabel.font = UIFont(name: "OpenSans-Semibold", size: 18)
    }
    
    private func setupParticipatedEpisodesLabel() {
        participatedEpisodesLabel.textColor = UIColor(red: 0.0118, green: 0.1451, blue: 0.2549, alpha: 1.0)
        participatedEpisodesLabel.font = UIFont(name: "OpenSans-Semibold", size: 18)
    }
}
