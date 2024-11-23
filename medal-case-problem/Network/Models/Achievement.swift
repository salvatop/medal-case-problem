//
//  Achievement.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

struct Achievement: Decodable {
    let title: String
    let result: String
    let achieved: Bool
    let iconName: String

    var icon: UIImage? {
        return UIImage(named: iconName)
    }
}
