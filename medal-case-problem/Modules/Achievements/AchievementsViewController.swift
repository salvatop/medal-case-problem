//
//  AchievementsViewController.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

class AchievementsViewController: UIViewController {
    let service = AchievementServiceApi()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.backgroundColor
        title = ScreenTitle.Achievements.rawValue

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .plain,
            target: self,
            action: #selector(didTapMenu)
        )

        fetchAchievements()
    }

    @objc private func didTapMenu() {
        print("Menu tapped")
    }

    private func fetchAchievements() {
        Task {
            do {
                let achievements = try await service.getAchievements()
                print("Achievements: \(achievements)")
            } catch {
                print("Error fetching achievements: \(error)")
            }
        }
    }
}
