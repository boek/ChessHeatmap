//
//  Player.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

struct Player: Equatable, Codable {
    var username: String
    var result: GameResult
    var rating: Int
}

extension Player {
    static var exampleA: Self {
        .init(username: "boek", result: .win, rating: 2000)
    }

    static var exampleB: Self {
        .init(username: "k0m", result: .lose, rating: 2000)
    }
}
