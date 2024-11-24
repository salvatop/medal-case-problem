//
//  HomeViewController.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

class HomeViewController: UIViewController {
    weak var coordinator: NavigationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        title = ScreenTitle.Home.rawValue
        
        setupUI()
    }
    
    private func setupUI() {
        let button = UIButton(type: .system)
        button.setTitle("Go to Achievements", for: .normal)
        button.addTarget(self, action: #selector(didTapGoToAchievements), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapGoToAchievements() {
        coordinator?.presentAchievementsView()
    }
}
