//
//  Game.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

struct Game: Identifiable, Equatable, Codable {
    var id: UUID { uuid }
    var uuid: UUID = UUID()
    var endTime: Date
    var white: GamePlayer
    var black: GamePlayer

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = UUID(uuidString: try container.decode(String.self, forKey: .uuid))!
        self.endTime = try container.decode(Date.self, forKey: .endTime)
        self.white = try container.decode(GamePlayer.self, forKey: .white)
        self.black = try container.decode(GamePlayer.self, forKey: .black)
    }
}
