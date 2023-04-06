//
//  Game.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

enum GameResult: String, Codable {
    case win, loss, checkmated, resigned
}

struct Player: Equatable, Codable {
    var username: String
    var result: GameResult
}

struct Game: Equatable, Codable {
    var endTime: Date
    var white: Player
    var black: Player
}
