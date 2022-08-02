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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titlesPosterImage: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFill
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlesPosterImage)
        contentView.addSubview(titleLabel)
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
            titlesPosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlesPosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            titlesPosterImage.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(titlesPosterImageConstraints)
    }
    
    public func configurePost(with posterPath: String, label: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)") else { return }
        titleLabel.text = label
        titlesPosterImage.sd_setImage(with: url, completed: nil)
    }

}
