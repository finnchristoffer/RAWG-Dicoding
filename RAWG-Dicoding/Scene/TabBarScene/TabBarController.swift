//
//  TabBarController.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 06/03/23.
//
//
import Foundation
import UIKit

class TabBarController: UITabBarController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())

        homeVC.title = "Home"
        searchVC.title = "Search"
        favoriteVC.title = "Favorite"
        profileVC.title = "Profile"

        self.setViewControllers([homeVC,searchVC,favoriteVC,profileVC], animated: true)

        guard let items = self.tabBar.items else {return}

        let imageItem = ["house.fill","magnifyingglass","heart.fill","person.fill"]

        for item in 0..<items.count {
            items[item].image = UIImage(systemName: imageItem[item])
        }
    }
}
