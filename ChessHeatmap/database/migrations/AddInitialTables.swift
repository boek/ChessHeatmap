//
//  AddInitialTables.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import SQLite
import SQLiteMigrationManager

struct AddInitialTables: Migration {
    var version: Int64 = 2023_04_06_21_02_01

    func migrateDatabase(_ db: Connection) throws {
        try db.run(Schema.Tables.players.create { t in
            t.column(Schema.Columns.id, primaryKey: true)
            t.column(Schema.Columns.name)
            t.column(Schema.Columns.username, unique: true)
            t.column(Schema.Columns.avatarURL)
        })

        try db.run(Schema.Tables.games.create {t in
            t.column(Schema.Columns.uuid, primaryKey: true)
            t.column(Schema.Columns.endTime)
            t.column(Schema.Columns.timeClass)
        })

        try db.run(Schema.Tables.gamePlayer.create { t in
            t.column(Schema.Columns.id, primaryKey: true)
            t.column(Schema.Columns.gameId)
            t.column(Schema.Columns.playerId)
            t.column(Schema.Columns.result)
        })
    }
}
