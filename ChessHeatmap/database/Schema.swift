//
//  Schema.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation
import SQLite

enum Schema {
    // MARK: Tables
    enum Tables {
        static let players    = Table("players")
        static let games      = Table("games")
        static let gamePlayer = Table("game_player")
        static let ratings    = Table("player_ratings")
    }

    // MARK: Columns
    enum Columns {
        static let id        = Expression<Int64>("id")
        static let uuid      = Expression<UUID>("id")
        static let avatarURL = Expression<String>("avatar_url")
        static let name      = Expression<String>("name")
        static let username  = Expression<String>("username")
        static let playerId  = Expression<Int64>("player_id")
        static let gameId    = Expression<UUID>("game_id")
        static let result    = Expression<String>("result")
        static let rating    = Expression<Int64>("rating")
        static let daily     = Expression<Int64>("daily")
        static let rapid     = Expression<Int64>("rapid")
        static let bullet    = Expression<Int64>("bullet")
        static let blitz     = Expression<Int64>("blitz")
        static let endTime   = Expression<Date>("end_time")
        static let timeClass = Expression<String>("time_class")
    }
}
