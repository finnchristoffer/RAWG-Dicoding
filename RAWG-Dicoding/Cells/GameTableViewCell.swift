//
//  GameTableViewCell.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var game: Game? {
        didSet {
            if let backgroundImage = game?.backgroundImage {
                let imageUrl = URL(string: backgroundImage)
                gameImageView.kf.setImage(with: imageUrl)
            }
            releasedLabel.text = "🗓 \(game?.released?.convertToString(format: "MMM dd, yyyy") ?? "") ⭐️ \(String(game?.rating ?? 0.0))"
            nameLabel.text = game?.name
        }
    }
    
    let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let releasedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.textColor = .white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(releasedLabel)
        contentView.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        gameImageView.anchor(top: contentView.topAnchor, bottom: nameLabel.topAnchor,leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingLeft: 20, paddingRight: 20)
        
        releasedLabel.anchor(bottom: gameImageView.bottomAnchor, leading: gameImageView.leadingAnchor, trailing: gameImageView.trailingAnchor, paddingTop: 5)
        
        nameLabel.anchor(bottom: contentView.bottomAnchor, leading: gameImageView.leadingAnchor, trailing: gameImageView.trailingAnchor, paddingBottom: 5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
