//
//  AchievementViewCell.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

final class AchievementViewCell: UICollectionViewCell {

    static let reuseIdentifier = "AchievementViewCell"

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.primaryColor
        label.font = Theme.Fonts.scaledFont(for: Theme.Fonts.collectionViewItem, textStyle: .footnote)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.primaryColor
        label.font = Theme.Fonts.scaledFont(for: Theme.Fonts.collectionViewItem, textStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        assertionFailure("This class does not support initialization via NSCoder.")
        return nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        timeLabel.text = nil
        icon.image = nil
    }

    private func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(timeLabel)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),

            icon.heightAnchor.constraint(equalToConstant: 60),
            icon.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    func configure(with achievement: Achievement) {
        titleLabel.text = achievement.title
        timeLabel.text = achievement.achieved ? achievement.result : "0:00:00"
        icon.image = achievement.icon

        let alpha: CGFloat = achievement.achieved ? 1.0 : 0.5
        titleLabel.alpha = alpha
        timeLabel.alpha = alpha
        icon.alpha = alpha
    }
}

