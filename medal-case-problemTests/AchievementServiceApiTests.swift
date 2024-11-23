//
//  medal_case_problemTests.swift
//  medal-case-problemTests
//
//  Created by Salvatore Palazzo on 2024-11-23.
//

import XCTest
@testable import medal_case_problem

final class AchievementServiceApiTests: XCTestCase {

    var service: AchievementServiceApi!

    override func setUpWithError() throws {
        try super.setUpWithError()
        service = AchievementServiceApi()
    }

    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }

    func testLoadAchievementsSuccess() async throws {
        let achievements = try await service.getAchievements()
        XCTAssertEqual(achievements.count, 12, "Expected 12 achievements, but got \(achievements.count).")
        guard let firstAchievement = achievements.first else {
            XCTFail("First achievement should not be nil.")
            return
        }

        XCTAssertEqual(firstAchievement.title, "Longest Run", "First achievement title mismatch.")
        XCTAssertEqual(firstAchievement.result, "00:00", "First achievement result mismatch.")
        XCTAssertEqual(firstAchievement.achieved, true, "First achievement achieved status mismatch.")
        XCTAssertEqual(firstAchievement.iconName, "longest_run", "First achievement icon name mismatch.")
        XCTAssertEqual(firstAchievement.category, "personal_records", "First achievement category mismatch.")
        XCTAssertNotNil(firstAchievement.icon, "First achievement icon should not be nil.")
    }

    func testLoadAchievementsFileNotFound() async {
        class MockAchievementServiceApi: AchievementServiceApi {
            override func getAchievements() async throws -> [Achievement] {
                guard Bundle.main.url(forResource: "NonExistentFile", withExtension: "json") != nil else {
                    throw ApiError.fileNotFound
                }
                return []
            }
        }
        let mockService = MockAchievementServiceApi()
        do {
            _ = try await mockService.getAchievements()
            XCTFail("Expected fileNotFound error, but the method succeeded.")
        } catch let error as ApiError {
            XCTAssertEqual(error, .fileNotFound, "Expected fileNotFound error, but got \(error).")
        } catch {
            XCTFail("Expected ApiError.fileNotFound but got \(error).")
        }
    }
}

