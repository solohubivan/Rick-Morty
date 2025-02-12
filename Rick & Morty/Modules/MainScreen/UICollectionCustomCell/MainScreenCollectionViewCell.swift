//
//  MainScreenCollectionViewCell.swift
//  Rick & Morty
//
//  Created by Ivan Solohub on 12.02.2025.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    private var blurView: UIVisualEffectView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func updateUI(with data: CharacterModel) {
        nameLabel.text = data.name
        loadImage(from: data.image)
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil, let image = UIImage(data: data) else { return }
                
            DispatchQueue.main.async {
                self.characterImageView.image = image
            }
        }.resume()
    }
    
    
    
    private func setupUI() {
        self.layer.cornerRadius = 10
        setupBlurBackground()
        setupNameLabel()
        setupCharacterImageView()
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
    }
    
    private func setupCharacterImageView() {
        characterImageView.image = UIImage(named: "mainVCBackground")
    }
}
