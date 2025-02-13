//
//  MainScreenViewController.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import UIKit

protocol MainScreenDisplayLogic: AnyObject {
    func displayCharacters(viewModel: MainScreenViewModel)
}

class MainScreenViewController: UIViewController {
    
    @IBOutlet weak private var charactersCollectionView: UICollectionView!
    
    private var interactor: MainScreenBusinessLogic?
    private var router: MainScreenRoutingLogic?
    
    private var characters: [CharacterModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCleanSwift()
        interactor?.fetchCharacters()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        charactersCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - Private methods
    private func setupCleanSwift() {
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()
        let router = MainScreenRouter()
        
        interactor.presenter = presenter
        presenter.viewController = self
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - UICollectionView properties
extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as? MainScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let character = characters[indexPath.item]
        cell.updateUI(with: character)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = UIDevice.current.orientation.isLandscape ? 2 : 1
        let padding: CGFloat = 32
        let totalSpacing = (itemsPerRow) * padding
        let width = (collectionView.frame.width - totalSpacing) / itemsPerRow
        return CGSize(width: width, height: width / 2.5)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight * 1.5 {
            interactor?.fetchCharacters()
        }
        
        navigationController?.navigationBar.prefersLargeTitles = offsetY <= 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        router?.routeToDetailScreen(from: self, with: character)
    }
}

// MARK: - Display Logic
extension MainScreenViewController: MainScreenDisplayLogic {
    func displayCharacters(viewModel: MainScreenViewModel) {
        self.characters.append(contentsOf: viewModel.characters)
        self.charactersCollectionView.reloadData()
    }
}

// MARK: - Setup UI
extension MainScreenViewController {
    private func setupUI() {
        self.title = "Rick and Morty"
        setupNavigationVC()
        setupCharactersCollectionView()
    }
    
    private func setupNavigationVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.modalPresentationStyle = .fullScreen
        navigationController?.overrideUserInterfaceStyle = .light
    }

    private func setupCharactersCollectionView() {
        let nib = UINib(nibName: "MainScreenCollectionViewCell", bundle: nil)
        charactersCollectionView.register(nib, forCellWithReuseIdentifier: "CellID")
            
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        
        charactersCollectionView.backgroundColor = .clear
    }
}
