//
//  SearchViewController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    private var vm: HomeViewModelProtocol = HomeViewModel()
    
    private lazy var searchStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "You can use the searchbar"
        return label
    }()
    
    private lazy var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "Find what kind of you want..."
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        return searchBar
    }()
    
    private lazy var gameListTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    let activityIndatorView = UIActivityIndicatorView(style: .medium)
    
    func showActivityIndicatory() {
        activityIndatorView.center = view.center
        activityIndatorView.hidesWhenStopped = true
        activityIndatorView.startAnimating()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        navigationItem.title = "Search Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        statusHelper(0)
        setupViews()
        setupConstraints()
        
        vm.delegate = self
        
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        view.addSubview(searchBar)
        gameListTableView.addSubview(searchStatusLabel)
        view.addSubview(gameListTableView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        searchBar.anchor(top: safeArea.topAnchor, left: safeArea.leftAnchor, right: safeArea.rightAnchor)
        
        
        gameListTableView.anchor(top: searchBar.bottomAnchor, left: safeArea.leftAnchor,bottom: safeArea.bottomAnchor ,right: safeArea.rightAnchor)
        
        searchStatusLabel.center(inView: safeArea)
    }
    
    private func statusHelper(_ status:Int){
        searchStatusLabel.tag = status
        switch status {
        case 0:
            searchStatusLabel.text = "You can use searchbar"
            searchStatusLabel.isHidden = false
        case 1:
            searchStatusLabel.isHidden = true
            showActivityIndicatory()
            view.addSubview(activityIndatorView)
        case 2:
            searchStatusLabel.text = "No Result"
            searchStatusLabel.isHidden = false
        case 3:
            searchStatusLabel.isHidden = true
        default:
            searchStatusLabel.isHidden = true
            searchStatusLabel.text = ""
        }
    }
}

extension SearchViewController: HomeViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
        activityIndatorView.stopAnimating()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = vm.getGameCount()
        if searchStatusLabel.tag == 0 {
            statusHelper(0)
        } else if count <= 0 {
            statusHelper(2)
        } else {
            statusHelper(3)
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.reuseIdentifier, for: indexPath) as? GameTableViewCell, let obj = vm.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.configureCell(obj)
        }
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let gameId = vm.getGameId(at: indexPath.row){
            let detailVC = GameDetailViewController()
            detailVC.gameId = gameId
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            statusHelper(1)
            vm.searchGames(text)
            self.view.endEditing(true)
        }
    }
}
