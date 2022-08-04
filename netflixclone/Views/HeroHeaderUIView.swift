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
        button.setTitle("Watch now", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Save in your list", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "spidermanLogo")
        return imageView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        setupStack()
        addSubview(stack)
        addSubview(logoImageView)
        applyConstraints()
        
    }
    
    private func setupStack() {
        stack.addArrangedSubview(saveMovieButton)
        stack.addArrangedSubview(playButton)
    }
    
    private func applyConstraints() {
        
        let stackConstraints = [
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            stack.leftAnchor.constraint(equalTo: leftAnchor, constant: 30),
            stack.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            stack.heightAnchor.constraint(equalToConstant: 45)
        ]
        
        let logoConstraints = [
            logoImageView.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 300),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ]
        
        NSLayoutConstraint.activate(stackConstraints)
        NSLayoutConstraint.activate(logoConstraints)
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
