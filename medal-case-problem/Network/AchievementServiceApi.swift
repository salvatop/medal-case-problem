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

struct Achievements: Decodable {
    let personalRecords: [Achievement]
    let virtualRaces: [Achievement]
}

final class AchievementServiceApi {
    func getAchievements() async throws -> Achievements {
        guard let url = Bundle.main.url(forResource: "Achievements", withExtension: "json") else {
            throw ApiError.fileNotFound
        }

        do {
            let data = try Data(contentsOf: url)
            let achievements = try JSONDecoder().decode(Achievements.self, from: data)
            return achievements
        } catch {
            throw ApiError.failedToDecode
        }
    }
}

