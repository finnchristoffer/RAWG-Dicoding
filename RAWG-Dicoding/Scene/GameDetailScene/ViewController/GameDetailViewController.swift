//
//  GameDetailViewController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import UIKit
import Kingfisher

class GameDetailViewController: UIViewController {
    // MARK: - Properties
    var gameId: Int?
    private var vm: GameDetailViewModelProtocol = GameDetailViewModel()
    
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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var gameInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.secondaryLabel
        label.textAlignment = .center
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
    
    private lazy var gameDetailLabel: UITextView = {
        let label = UITextView()
        label.textColor = .label
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEditable = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var RateCapsule: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    private lazy var DateCapsule: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemBlue
        return button
    }()
    
    private lazy var ScoreCapsule: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.tintColor = UIColor.label
        button.backgroundColor = UIColor.systemBlue
        return button
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
    
    let gameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.delegate = self
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        guard let id = gameId else {return}
        vm.fetchGameDetail(id)
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        view.backgroundColor = UIColor.systemBackground
        
        view.addSubview(gameImageView)
        view.addSubview(gamePublisherLabel)
        view.addSubview(gameTitleLabel)
        view.addSubview(gameInfoLabel)
        infoStackView.addArrangedSubview(RateCapsule)
        infoStackView.addArrangedSubview(DateCapsule)
        infoStackView.addArrangedSubview(ScoreCapsule)
        view.addSubview(infoStackView)
        view.addSubview(gameDetailLabel)
        gameStackView.addArrangedSubview(platformPC)
        gameStackView.addArrangedSubview(platformXbox)
        gameStackView.addArrangedSubview(platformSony)
        gameStackView.addArrangedSubview(platformNintendo)
        view.addSubview(gameStackView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        gameImageView.anchor(top: safeArea.topAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, height: 200 ,paddingTop: 5, paddingLeft: 15, paddingRight: 15)
        
        gamePublisherLabel.anchor(top: gameImageView.bottomAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 15)
        
        gameTitleLabel.anchor(top: gamePublisherLabel.bottomAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
        
        gameInfoLabel.anchor(top: gameTitleLabel.bottomAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, paddingTop: 10, paddingLeft: 15, paddingRight: 15)
        
        infoStackView.anchor(top: gameInfoLabel.bottomAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, paddingTop: 15, paddingLeft: 40, paddingRight: 40)
        
        gameDetailLabel.anchor(top: infoStackView.bottomAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, width: 200, height: 250 ,paddingTop: 30, paddingLeft: 15, paddingRight: 15)
        
        gameStackView.anchor(top: gameDetailLabel.bottomAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor, paddingTop: 25, paddingLeft: 15, paddingRight: 15)
        
    }
    
    
    // MARK: - Actions
    @objc func pressInfoGame(_ sender: Any) {
        if let url = URL(string: Globals.sharedInstance.backlinkHelper(id: gameId)) {
            UIApplication.shared.open(url)
        }
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
    
    
}

extension GameDetailViewController: GameDetailViewModelDelegate {
    func gameLoaded() {
        self.gamePublisherLabel.text = self.vm.getGamePublisher()
        self.gameTitleLabel.text = self.vm.getGameTitle()
        self.gameInfoLabel.text = self.vm.getGameInfo()
        self.RateCapsule.setTitle(self.vm.getGameRating(), for: .normal)
        if let date = self.vm.getGameDate() {
            self.DateCapsule.setTitle(date, for: .normal)
        } else {
            self.DateCapsule.setTitle("Release Date", for: .normal)
        }
        
        if let score = self.vm.getGameScore() {
            self.ScoreCapsule.setTitle(score, for: .normal)
        } else {
            self.ScoreCapsule.setTitle("", for: .normal)
            self.ScoreCapsule.setImage(UIImage(systemName: "star.slash"), for: .normal)
        }
        self.gameDetailLabel.text = self.vm.getGameDetail()
        
        self.gameImageView.kf.indicatorType = .activity
        self.gameImageView.kf.setImage(with: self.vm.getGameImageUrl(640), placeholder: nil)
        
        if let platforms = self.vm.getGamePlatforms(){
            for i in platforms{
                self.enablePlatform(id: i.platform?.id ?? 0)
            }
        }
    }
}
