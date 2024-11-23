//
//  Theme.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

struct Theme {

    static let navigationBarBackgroundColor = UIColor.systemBlue
    static let navigationBarFontColor = UIColor.white

    static let backgroundColor = UIColor.systemBackground

    static let primaryColor = UIColor.black

    static func apply() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = navigationBarBackgroundColor
        appearance.titleTextAttributes = [
            .foregroundColor: navigationBarFontColor,
            .font: CommonFonts.scaledFont(for: CommonFonts.navigationBarTitle, textStyle: .headline)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = Theme.navigationBarFontColor
    }
}

