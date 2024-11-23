//
//  AchievementsViewController.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

class AchievementsViewController: UIViewController, UICollectionViewDelegate {
    private let service = AchievementServiceApi()

    private var achievements: [Achievement] = []
    private var achievementsByCategory: [String: [Achievement]] = [:]
    private var categories: [String] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 180)
        layout.headerReferenceSize = CGSize(width: view.frame.width, height: 40)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Theme.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AchievementViewCell.self, forCellWithReuseIdentifier: AchievementViewCell.reuseIdentifier)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewCell.reuseIdentifier)
        return collectionView
    }()

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
        setupViews()
        fetchAchievements()
    }

    @objc private func didTapMenu() {
        print("Menu tapped")
    }

    private func setupViews() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchAchievements() {
        Task {
            do {
                achievements = try await service.getAchievements()
                groupAchievementsByCategory(achievements)
                collectionView.reloadData()
            } catch {
                print("Failed to fetch achievements: \(error)")
            }
        }
    }

    private func groupAchievementsByCategory(_ achievements: [Achievement]) {
        achievementsByCategory = Dictionary(grouping: achievements, by: { $0.category })
        categories = achievementsByCategory.keys.sorted()
    }
}

// MARK: - UICollectionViewDataSource
extension AchievementsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let category = categories[section]
        return achievementsByCategory[category]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AchievementViewCell.reuseIdentifier, for: indexPath) as? AchievementViewCell else {
            return UICollectionViewCell()
        }

        let category = categories[indexPath.section]
        if let achievement = achievementsByCategory[category]?[indexPath.row] {
            cell.configure(with: achievement)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.reuseIdentifier, for: indexPath) as? HeaderViewCell else {
            return UICollectionReusableView()
        }
        let category = categories[indexPath.section]
        let total = achievementsByCategory[category]?.count ?? 0
        let achieved = achievementsByCategory[category]?.filter { $0.achieved }.count ?? 0
        header.configure(title: category, achievedCount: achieved, totalCount: total)
        return header
    }
}
