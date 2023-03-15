//
//  HomeViewController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    var orderCase = 0
    private var homeView: HomeView!
    private var vm: HomeViewModelProtocol = HomeViewModel()
    
    private lazy var orderButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.image = UIImage(systemName: "line.horizontal.3.decrease")
        button.action = #selector(orderListAction)
        return button
    }()
    
    let activityIndatorView = UIActivityIndicatorView(style: .medium)
    
    func showActivityIndicatory() {
        activityIndatorView.center = view.center
        activityIndatorView.hidesWhenStopped = true
        activityIndatorView.startAnimating()
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        homeView = HomeView(frame: view.frame)
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        homeView.setupConstraints()
        
        vm.fetchPopularGames()
        vm.delegate = self

    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        navigationItem.title = "Popular Games"
        navigationItem.rightBarButtonItem = orderButton
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor.systemBackground
        
        homeView.gameListTableView.delegate = self
        homeView.gameListTableView.dataSource = self
        
        showActivityIndicatory()
        view.addSubview(activityIndatorView)
    }
    
    @objc private func orderListAction(_ sender: Any) {
        orderCase += 1
        switch orderCase {
        case 1:
            vm.orderList(opt: orderCase)
            orderButton.image = UIImage(systemName: "a.square")
        case 2:
            vm.orderList(opt: orderCase)
            orderButton.image = UIImage(systemName: "30.square")
        case 3:
            vm.orderList(opt: orderCase)
            orderButton.image = UIImage(systemName: "star.square")
        default:
            vm.orderList(opt: orderCase)
            orderButton.image = UIImage(systemName: "line.horizontal.3.decrease")
            orderCase = 0
        }
    }
}


// MARK: - Delegate Functions
extension HomeViewController: HomeViewModelDelegate {
    func gamesLoaded() {
        homeView.gameListTableView.reloadData()
        activityIndatorView.stopAnimating()
    }
}


// MARK: - Tableview Functions
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let gameId = vm.getGameId(at: indexPath.row) {
            let detailVC = GameDetailViewController()
            detailVC.gameId = gameId
            detailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
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

