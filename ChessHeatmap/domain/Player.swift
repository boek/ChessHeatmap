//
//  Player.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

struct Player: Equatable, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "player_id"
        case avatarURL = "avatar"
        case name, username
    }

    enum GamePlayerCodingKeys: String, CodingKey {
        case uuid
        case username
    }

    var id: ID<Int64>
    var name: String
    var username: String
    var avatarURL: String

    init(
        id: ID<Int64>,
        name: String,
        username: String,
        avatarURL: String
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.avatarURL = avatarURL
    }

    init(gamePlayer: Decoder) throws {
        let container = try gamePlayer.container(keyedBy: GamePlayerCodingKeys.self)
        self.id = .none
        self.avatarURL = ""
        self.name = ""
        self.username = try container.decode(String.self, forKey: .username)
    }
}

extension Player {
    static var test: Self {
        .init(id: .none, name: "Jeff Boek", username: "boek", avatarURL: "this-is-a-path")
    }
}
