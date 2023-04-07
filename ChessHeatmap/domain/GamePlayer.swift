//
//  GamePlayer.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

struct GamePlayer: Equatable, Codable {
    var id: ID<Int64> = .none
    var player: Player
    var result: GameResult
    var rating: Int

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = .none
        self.player = try Player(gamePlayer: decoder)
        self.result = try container.decode(GameResult.self, forKey: .result)
        self.rating = try container.decode(Int.self, forKey: .rating)
    }
}
