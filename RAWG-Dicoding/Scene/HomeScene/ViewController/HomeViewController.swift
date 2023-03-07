//
//  HomeViewController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var orderCase = 0
    private var vm: HomeViewModelProtocol = HomeViewModel()
    
    private lazy var activityIdicator: UIActivityIndicatorView = {
       let activity = UIActivityIndicatorView()
        return activity
    }()
    
    private lazy var gameListTableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.reuseIdentifier)
        tableView.rowHeight = 150.0
        return tableView
    }()
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("POPULAR_GAMES", comment: "Popular games")
        vm.delegate = self
        activityIdicator.startAnimating()
        vm.fetchPopularGames()
        
        setupViews()
        setupConstraints()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "HometoDetail":
            if let gameId = sender as? Int {
                let goalVC = segue.destination as! GameDetailViewController
                goalVC.gameId = gameId
            }
        default:
            print("Identifier not found")
        }
    }
    // MARK: - Helpers
    
    private func setupViews() {
        view.addSubview(gameListTableView)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        gameListTableView.anchor(top: safeArea.topAnchor, left: safeArea.leftAnchor, bottom: safeArea.bottomAnchor, right: safeArea.rightAnchor)
    }
}


// MARK: - Delegate Functions
extension HomeViewController: HomeViewModelDelegate {
    func gamesLoaded() {
        gameListTableView.reloadData()
        activityIdicator.stopAnimating()
    }
}


// MARK: - Tableview Functions
extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getGameCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.reuseIdentifier, for: indexPath) as? GameTableViewCell, let obj = vm.getGame(at: indexPath.row) else {return UITableViewCell()}
        DispatchQueue.main.async {
            cell.configureCell(obj)
        }
        return cell
    }
}
