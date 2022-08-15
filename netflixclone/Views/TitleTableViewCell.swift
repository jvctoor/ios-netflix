//
//  TitleTableViewCell.swift
//  netflixclone
//
//  Created by João Victor on 02/08/22.
//

import UIKit


class TitleTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"
    
    
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private let titlesPosterImage: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        poster.clipsToBounds = true
        return poster
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .systemGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(playButton)
        applyConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func applyConstraints() {
        let titlesPosterImageConstraints = [
            titlesPosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlesPosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            titlesPosterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterImage.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: -40)
        ]
        
        let overviewConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            overviewLabel.leadingAnchor.constraint(equalTo: titlesPosterImage.trailingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: -40)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(titlesPosterImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    public func configurePost(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        titleLabel.text = model.titleName
        
        if let overviewText = model.overview {
            overviewLabel.text = overviewText
        }
        
        titlesPosterImage.sd_setImage(with: url, completed: nil)
    }

}
