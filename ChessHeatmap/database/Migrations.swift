//
//  Migrations.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation
import SQLite
import SQLiteMigrationManager

struct Migrations {
    private var manager: SQLiteMigrationManager

    init(db: Connection) {
        self.manager = SQLiteMigrationManager(db: db, migrations: [
            AddInitialTables()
        ])
    }

    func appliedVersions() -> [Int64] {
        return manager.appliedVersions()
    }

    func migrate() throws {
        if !manager.hasMigrationsTable() {
            try manager.createMigrationsTable()
        }

        if manager.needsMigration() {
            try manager.migrateDatabase()
        }
    }
}
