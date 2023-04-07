//
//  ChessClientTests.swift
//  ChessHeatmapTests
//
//  Created by Jeff Boek on 4/6/23.
//

import XCTest
@testable import ChessHeatmap

final class ChessClientTests: XCTestCase {
    func testThatWeCanFetchSomeGames() async throws {
        let client = ChessClient.live
        let games = try await client.fetchGames(.init(user: "k0m", year: 2023, month: .april))
        XCTAssertEqual(games.count, 5)
    }

    func testThatWeCanFetchAUser() async throws {
        let client = ChessClient.live
        let player = try await client.fetchPlayer("k0m")
        XCTAssertEqual("Jeff Boek", player.name)
    }
}
