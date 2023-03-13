//
//  GameTableViewCell.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "GameTableViewCell"
    
    // MARK: - Properties
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
    
    private lazy var gameSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gameDateReleaseLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var platformPC: UIButton = {
       let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "desktopcomputer")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var platformXbox: UIButton = {
       let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "xbox.logo")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var platformSony: UIButton = {
       let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "playstation.logo")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var platformNintendo: UIButton = {
       let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "n.square.fill")
        button.setImage(image, for: .normal)
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
    
    let gameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
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
        enablePlatform(id: -1)
        gameImageView.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Helpers
    
    private func setupViews() {
        addSubview(RateCapsule)
        gameImageView.addSubview(RateCapsule)
        addSubview(gameImageView)
        addSubview(gameTitleLabel)
        addSubview(gameSubtitleLabel)
        gameStackView.addArrangedSubview(platformPC)
        gameStackView.addArrangedSubview(platformXbox)
        gameStackView.addArrangedSubview(platformSony)
        gameStackView.addArrangedSubview(platformNintendo)
        addSubview(gameStackView)
        addSubview(gameDateReleaseLabel)
    }
    
    private func setupConstraints() {
        gameImageView.anchor(top: topAnchor, bottom: bottomAnchor, width: 85, height: 125 ,leading: leadingAnchor,  paddingTop: 10, paddingLeft: 15, paddingBottom: 12)
        
        gameTitleLabel.anchor(top: topAnchor, left: gameImageView.rightAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        gameSubtitleLabel.anchor(top: gameTitleLabel.bottomAnchor, left: gameImageView.rightAnchor, paddingTop: 10, paddingLeft: 10)
        
        gameStackView.anchor(top: gameSubtitleLabel.bottomAnchor, left: gameImageView.rightAnchor, paddingTop: 10, paddingLeft: 10)
        
        gameDateReleaseLabel.anchor(top: gameStackView.bottomAnchor, left: gameImageView.rightAnchor, paddingTop: 15, paddingLeft: 10)
        
        RateCapsule.anchor(top: gameImageView.topAnchor, leading: gameImageView.leadingAnchor)
    }
    
    func configureCell(_ game:RawgModel){
        gameTitleLabel.text = game.name
        gameSubtitleLabel.text = gameInfoCreator(game)
        gameDateReleaseLabel.text = gameInfoDate(game)
        changeImage(imgUrl: game.imageWide)
        if let platforms = game.parentPlatforms{
            for i in platforms{
                enablePlatform(id: i.platform?.id ?? 0)
            }
        }
        RateCapsule.setTitle(gameInfoRate(game), for: .normal)
    }
    
    private func gameInfoCreator(_ game:RawgModel) -> String{
        var genreString = ""
        if let genres = game.genres, ((game.genres?.count ?? 0) != 0){
            for i in genres{
                genreString += i.name ?? ""
                genreString += ", "
            }
            genreString.removeLast(2)
        }
        return "\(genreString)"
    }
    
    private func gameInfoDate(_ game:RawgModel) -> String {
        let dateString = (game.tba ?? false) ? "TBA" : (game.released ?? "TBA")
        return "Released date: \(dateString)"
    }
    
    private func gameInfoRate(_ game:RawgModel) -> String {
        Globals.sharedInstance.Esrb(id: game.rating?.id)
    }
    
    private func enablePlatform(id:Int){
        switch id {
        case -1:
            platformPC.isHidden = true
            platformXbox.isHidden = true
            platformSony.isHidden = true
            platformNintendo.isHidden = true
        case 1:
            platformPC.isHidden = false
        case 2:
            platformSony.isHidden = false
        case 3:
            platformXbox.isHidden = false
        case 7:
            platformNintendo.isHidden = false
        default:
            break
        }
    }
    
    private func changeImage(imgUrl:String?){
        if let imgSized = Globals.sharedInstance.resizeImageRemote(imgUrl: imgUrl){
            guard let url = URL(string: imgSized) else { return }
            DispatchQueue.main.async {
                self.gameImageView.kf.setImage(with: url, placeholder: nil)
            }
        }
    }
}
