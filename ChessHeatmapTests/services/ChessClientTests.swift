//
//  ChessClientTests.swift
//  ChessHeatmapTests
//
//  Created by Jeff Boek on 4/6/23.
//

import XCTest
@testable import ChessHeatmap

final class ChessClientTests: XCTestCase {
    func testThatWeCanPullFromTheAPI() async throws {
        let client = ChessClient.live
        let games = try await client.fetchGames(.init(user: "k0m", year: 2023, month: .april))
        XCTAssertEqual(games, [])
    }
}
