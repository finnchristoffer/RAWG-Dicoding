//
//  ProfileController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 06/03/23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    private var name: String = ""
    private var about: String = ""
    private var email: String = ""
    private var image: UIImage?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.attributedText = NSAttributedString(string: email, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.textColor = UIColor.label
        return label
    }()
    
    private lazy var aboutTitle: UILabel = {
       let label = UILabel()
        label.text = "About"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.label
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = UIColor.label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var editButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.image = UIImage(systemName: "square.and.pencil")
        button.target = self
//        button.action = #selector(editButtonTapped)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        synchronizeProfile()
        updateUI()
    }
    
    // MARK: - Helpers

    private func setupViews() {
        
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(aboutTitle)
        view.addSubview(aboutLabel)

        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = editButton
    }
    
    private func setupConstraints() {

        let safeArea = view.safeAreaLayoutGuide
        
        imageView.centerX(in: view.centerXAnchor)
        imageView.anchor(top: safeArea.topAnchor, width: 200, height: 200, paddingTop: 16)
        
        nameLabel.anchor(top: imageView.bottomAnchor, left: safeArea.leftAnchor, paddingTop: 25, paddingLeft: 15)
        
        emailLabel.anchor(top: nameLabel.bottomAnchor, left: safeArea.leftAnchor, paddingTop: 7, paddingLeft: 15)
        
        aboutTitle.anchor(top: emailLabel.bottomAnchor, left: safeArea.leftAnchor, paddingTop: 40, paddingLeft: 15)
        
        aboutLabel.anchor(top: aboutTitle.bottomAnchor, left: safeArea.leftAnchor, paddingTop: 7, paddingLeft: 15)
        
    }
    
    private func synchronizeProfile() {
        ProfileModel.synchronize()
        if !ProfileModel.name.isEmpty && !ProfileModel.about.isEmpty && !ProfileModel.email.isEmpty {
            name = ProfileModel.name
            about = ProfileModel.about
            email = ProfileModel.email
            image = UIImage(data: ProfileModel.image)
        } else {
            name = "Finn Christoffer Kurniawan"
            about = "iOS Developer \nApple Developer Academy Graduate"
            email = "finn.christoffer@gmail.com"
        }
    }
    
    private func updateUI() {
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = UIImage(named: "me")
        }
        nameLabel.text = name
        emailLabel.text = email
        aboutLabel.text = about
    }
    
//    @objc private func editButtonTapped() {
//        let editProfileViewController = EditProfileViewController()
//        navigationController?.pushViewController(editProfileViewController, animated: true)
//    }
}
