//
//  MainTabBarController.swift
//  MoviesApp
//
//  Created by gawin on 29/12/2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let moviesVC = MoviesViewController()
        let favoritesVC = FavoritesViewController()
        
        let moviesNavController = UINavigationController(rootViewController: moviesVC)
        let favoritesNavController = UINavigationController(rootViewController: favoritesVC)
        
        moviesNavController.tabBarItem = UITabBarItem(
            title: "Movies",
            image: UIImage(systemName: "film"),
            selectedImage: UIImage(systemName: "film.fill")
        )
        
        favoritesNavController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "star"),
            selectedImage: UIImage(systemName: "star.fill")
        )
        
        setViewControllers([moviesNavController, favoritesNavController], animated: false)
    }

}
