//
//  NavigationCoordinator.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func presentHomeView()
}

public enum ScreenTitle: String {
    case home = "Home"
    case achievements = "Achievements"
}


class NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func presentHomeView() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        navigationController.setViewControllers([homeVC], animated: false)
    }

    func presentAchievementsView() {
        let achievementsVC = AchievementsViewController()
        navigationController.pushViewController(achievementsVC, animated: true)
    }
}
