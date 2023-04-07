//
//  MigrationsTests.swift
//  ChessHeatmapTests
//
//  Created by Jeff Boek on 4/6/23.
//

import XCTest
import SQLite
@testable import ChessHeatmap

final class MigrationsTests: XCTestCase {
    func testThatWeCanMigrate() throws {
        let db = try Connection(.inMemory)

        let migrations = Migrations(db: db)
        XCTAssertEqual([], migrations.appliedVersions())

        try migrations.migrate()
        XCTAssertEqual([
            AddInitialTables().version
        ], migrations.appliedVersions())
    }
}
