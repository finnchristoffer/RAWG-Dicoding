//
//  FavoriteTableViewCell.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 14/03/23.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "FavoriteTableViewCell"
    
    private lazy var gameImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 7.5
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var gameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gamePublisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ScoreCapsule: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    private lazy var RateCapsule: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    private lazy var dateCapsule: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemBlue
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        return button
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        gameImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    
    private func setupViews() {
        addSubview(gameImage)
        addSubview(gameTitleLabel)
        addSubview(gamePublisherLabel)
        infoStackView.addArrangedSubview(RateCapsule)
        infoStackView.addArrangedSubview(ScoreCapsule)
        addSubview(infoStackView)
        addSubview(dateCapsule)
    }
    
    private func setupConstraints() {
        gameImage.anchor(top: topAnchor, width: 175, height: 115, leading: leadingAnchor, paddingTop: 15)
        
        gamePublisherLabel.anchor(top: gameImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 10, paddingBottom: 10)
        gamePublisherLabel.setDimensions(width: gameImage.widthAnchor,widthMultiplier: 1)
        
        gameTitleLabel.anchor(top: topAnchor, left: gameImage.rightAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 15)
        
        infoStackView.anchor(top: gameTitleLabel.bottomAnchor, left: gameImage.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 15)
        
        dateCapsule.anchor(top: infoStackView.bottomAnchor, left: gameImage.rightAnchor, bottom: bottomAnchor ,right: rightAnchor, height: 30, paddingTop: 10, paddingLeft: 10, paddingBottom: 50 ,paddingRight: 15)
        
    }
    
    func configureCell(_ game: RawgDetailModel){
        gameTitleLabel.text = game.name
        setPublisherLabel(game)
        setGameRating(game.rating?.id)
        setGameScore(metacritic: game.metacritic)
        setGameDate(game)
        
        changeImage(imgUrl: game.imageWide)
        
    }
    
    private func setGameRating(_ id: Int?) {
        RateCapsule.setTitle(Globals.sharedInstance.Esrb(id: id), for: .normal)
    }
    
    private func setGameDate(_ game: RawgDetailModel) {
        if game.tba ?? false || game.released == nil {
            dateCapsule.setTitle("", for: .normal)
            return
        }
        dateCapsule.setTitle(Globals.sharedInstance.formatDate(date:"  \(game.released!)"), for: .normal)
    }
    
    private func setGameScore(metacritic: Int?) {
        if let score: Int = metacritic {
            ScoreCapsule.setTitle(String(score), for: .normal)
            self.ScoreCapsule.setImage(UIImage(systemName: "star.fill"), for: .normal)
            return
        }
        ScoreCapsule.setTitle("", for: .normal)
        ScoreCapsule.setImage(UIImage(systemName: "star.slash"), for: .normal)
    }
    
    private func setPublisherLabel(_ game: RawgDetailModel) {
        var leadStudio = ""
        var mainPublisher = ""
        if let studios = game.developers {
            if studios.count > 0 {
                leadStudio = studios[0].name ?? "-"
            }
        }
        
        if let publishers = game.publishers {
            if publishers.count > 0 {
                mainPublisher = publishers[0].name ?? "-"
            }
        }
        
        gamePublisherLabel.text = "\(leadStudio), \(mainPublisher)"
    }
    
    private func changeImage(imgUrl: String?) {
        if let imgSized = Globals.sharedInstance.resizeImageRemote(imgUrl: imgUrl) {
            guard let url = URL(string: imgSized) else {return}
            DispatchQueue.main.async {
                self.gameImage.kf.setImage(with: url, placeholder: nil)
            }
        }
    }
}
