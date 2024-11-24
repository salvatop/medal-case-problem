//
//  Theme.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

struct Theme {
    
    static let navigationBarBackgroundColor = hexColor("#63C6D4")
    static let navigationBarFontColor = hexColor("#FFFFFF")
    
    static let backgroundColor = hexColor("#FFFFFF")
    
    static let primaryColor = hexColor("#000000")
    
    static let collectionViewHeaderBackgroundColor = hexColor("#F7F7F7")
    static let collectionViewHeaderTitledColor = hexColor("#333333")
    static let collectionViewHeaderSubTitledColor = hexColor("#666666")
    
    static func apply() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = navigationBarBackgroundColor
        appearance.titleTextAttributes = [
            .foregroundColor: navigationBarFontColor,
            .font: Theme.Fonts.scaledFont(for: Theme.Fonts.navigationBarTitle, textStyle: .headline)
        ]
        
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        appearance.backButtonAppearance = backButtonAppearance
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = Theme.navigationBarFontColor
    }
    
    static func hexColor(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }
        
        guard cleanedHex.count == 6 else {
            return UIColor.white
        }
        
        let scanner = Scanner(string: cleanedHex)
        var hexValue: UInt64 = 0
        scanner.scanHexInt64(&hexValue)
        
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    
    struct Fonts {
        
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
}

