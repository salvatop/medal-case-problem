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


class NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func presentHomeView() {
        let homeVC = HomeViewController()
        homeVC.coordinator = self
        setupNavigationBar()
        navigationController.setViewControllers([homeVC], animated: false)
    }

    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .white
    }

    func presentAchievementsView() {
        navigationController.topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        let achievementsVC = AchievementsViewController()
        navigationController.pushViewController(achievementsVC, animated: true)
    }
}
