//
//  MainScreenCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var characterImageView: UIImageView!
    @IBOutlet weak private var aliveAndSpeciesLabel: UILabel!
    @IBOutlet weak private var characterOriginLabel: UILabel!
    private var blurView: UIVisualEffectView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    // MARK: - Public methods
    func updateUI(with data: CharacterModel) {
        nameLabel.text = data.name
        aliveAndSpeciesLabel.text = "\(data.status.capitalized) - \(data.species.capitalized)"
        characterOriginLabel.text = "\(AppConstants.CharacterParameters.origin): \(data.origin.name)"

        guard let imageData = data.imagePicture, let image = UIImage(data: imageData) else {
            loadImage(from: data.image)
            return
        }
        
        characterImageView.image = image
    }
    
    // MARK: - Private methods
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.characterImageView.image = image
            }
        }.resume()
    }
}

// MARK: - Setup UI
extension MainScreenCollectionViewCell {
    
    private func setupUI() {
        self.layer.cornerRadius = 10
        setupBlurBackground()
        setupNameLabel()
        setupAliveAndSpeciesLabel()
        setupCharacterOriginLabel()
    }
    
    private func setupBlurBackground() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.insertSubview(blurView, at: 0)
        self.blurView = blurView
    }
    
    private func setupNameLabel() {
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: AppConstants.Fonts.openSansSemibold, size: 24)
    }
    
    private func setupAliveAndSpeciesLabel() {
        aliveAndSpeciesLabel.font = UIFont(name: AppConstants.Fonts.openSansRegular, size: 18)
    }
    
    private func setupCharacterOriginLabel() {
        characterOriginLabel.font = UIFont(name: AppConstants.Fonts.openSansRegular, size: 16)
    }
}
