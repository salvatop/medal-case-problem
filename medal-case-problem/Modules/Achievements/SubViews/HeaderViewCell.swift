//
//  HeaderViewCell.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//


import UIKit

enum AchievementCategory: String {
    case personalRecords = "personal_records"
    case virtualRaces = "virtual_races"
}

final class HeaderViewCell: UICollectionViewCell {

    static let reuseIdentifier = "HeaderViewCell"

    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.collectionViewHeaderTitledColor
        label.font = CommonFonts.scaledFont(for: CommonFonts.collectionViewHeader , textStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var achievedLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.collectionViewHeaderSubTitledColor
        label.font = CommonFonts.scaledFont(for: CommonFonts.collectionViewHeader , textStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    required init?(coder: NSCoder) {
        assertionFailure("This class does not support initialization via NSCoder.")
        return nil
    }

    private func setupViews() {
        backgroundColor = .systemGray6
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(achievedLabel)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    func configure(title: String, achievedCount: Int, totalCount: Int) {
        titleLabel.text = title.capitalized.replacingOccurrences(of: "_", with: " ")
        if title == AchievementCategory.personalRecords.rawValue {
            achievedLabel.text = "\(achievedCount)/\(totalCount)"
        }
    }
}
