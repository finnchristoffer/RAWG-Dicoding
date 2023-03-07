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
        let profileVC = UINavigationController(rootViewController: ProfileViewController())

        homeVC.title = "Home"
        profileVC.title = "Search"

        self.setViewControllers([homeVC, profileVC], animated: true)

        guard let items = self.tabBar.items else {return}

        let imageItem = ["house.fill", "person.fill"]

        for item in 0..<items.count {
            items[item].image = UIImage(systemName: imageItem[item])
        }
    }
}
