//
//  EditProfileViewController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 06/03/23.
//

import UIKit

class EditProfileViewController: UIViewController {
    // MARK: - Properties
    
    var selectedImage: UIImage?
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        return scrollview
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var aboutTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "About..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 100
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
//    private lazy var saveButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Save", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var emptyFieldAlert: UIAlertController = {
        let alert = UIAlertController(title: "Warning", message: "Please fill in all fields!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        return picker
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        
        
    }
    // MARK: - Helpers
    
    private func setupViews() {
        view.addSubview(profileImageView)
        view.addSubview(nameTextField)
        view.addSubview(aboutTextField)
//        view.addSubview(saveButton)
    }
    
    private func setupConstraint() {
        
    }
    
        
        }
