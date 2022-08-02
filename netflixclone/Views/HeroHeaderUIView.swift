//
//  HeroHeaderUIView.swift
//  netflixclone
//
//  Created by João Victor on 28/07/22.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let saveMovieButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Save in your list", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Watch now", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(saveMovieButton)
        applyConstraints()
        
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            playButton.widthAnchor.constraint(equalToConstant: 130),
            playButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let saveConstraints = [
            saveMovieButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            saveMovieButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            saveMovieButton.widthAnchor.constraint(equalToConstant: 160),
            saveMovieButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(saveConstraints)
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        heroImageView.frame = bounds
    }
    
}
