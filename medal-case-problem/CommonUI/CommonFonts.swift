//
//  CommonFonts.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

struct CommonFonts {

    static let collectionViewHeader = UIFont.preferredFont(forTextStyle: .subheadline)
        .withSize(14)

    static let collectionViewItem = UIFont.preferredFont(forTextStyle: .footnote)
        .withSize(12)

    static let navigationBarTitle = UIFont.preferredFont(forTextStyle: .headline)
        .withSize(16)

    static func scaledFont(for font: UIFont, textStyle: UIFont.TextStyle) -> UIFont {
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }
}
