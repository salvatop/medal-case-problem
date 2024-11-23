//
//  AchievementServiceApi.swift
//  medal-case-problem
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import UIKit

enum ApiError: Error {
    case fileNotFound
    case failedToDecode
}

final class AchievementServiceApi {
    func getAchievements() async throws -> [Achievement] {
        guard let url = Bundle.main.url(forResource: "Achievements", withExtension: "json") else {
            throw ApiError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: url)
            let achievements = try JSONDecoder().decode([Achievement].self, from: data)
            return achievements
        } catch {
            throw ApiError.failedToDecode
        }
    }

}

