//
//  FavoriteSceneViewController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 15/03/23.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel: FavoriteViewModelProtocol = FavoriteViewModel()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "There is no favorite games"
        return label
    }()
    
    lazy var favoriteListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let activityIndator = UIActivityIndicatorView(style: .medium)
    
    func showActivityIndicatory() {
        activityIndator.center = view.center
        activityIndator.hidesWhenStopped = true
        activityIndator.startAnimating()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite Games"

        viewModel.delegate = self
        viewModel.fetchFavoriteGames()
        Globals.sharedInstance.isFavoriteChanged = false
        setupViews()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Globals.sharedInstance.isFavoriteChanged {
            showActivityIndicatory()
            view.addSubview(activityIndator)
            viewModel.fetchFavoriteGames()
        }
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(favoriteListTableView)
        favoriteListTableView.addSubview(statusLabel)
        
        showActivityIndicatory()
        view.addSubview(activityIndator)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        favoriteListTableView.anchor(top: safeArea.topAnchor, left: safeArea.leftAnchor,bottom: safeArea.bottomAnchor, right: safeArea.rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
        
        statusLabel.center(inView: safeArea)
        
    }
}

extension FavoriteViewController: FavoriteViewModelDelegate {
    func favoritesLoaded() {
        favoriteListTableView.reloadData()
        favoriteListTableView.isHidden = false
        activityIndator.stopAnimating()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.getGameCount()
        if count <= 0 {
            statusLabel.isHidden = false
        } else {
            statusLabel.isHidden = true
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell, let obj = viewModel.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.configureCell(obj)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gameId = viewModel.getGameId(at: indexPath.row) {
            let detailVC = GameDetailViewController()
            detailVC.gameId = gameId
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
