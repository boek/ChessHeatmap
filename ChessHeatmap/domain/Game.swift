//
//  Game.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

struct Game: Identifiable, Equatable, Codable {
    var id: String { uuid }
    var uuid: String = UUID().uuidString
    var endTime: Date
    var white: Player
    var black: Player
}

extension Game {
    static var exampleA: Game {
        .init(
            endTime: Calendar.current.date(byAdding: .day, value: 1, to: .distantPast)!,
            white: .exampleA,
            black: .exampleB
        )
    }

    static var exampleB: Game {
        .init(
            endTime: Calendar.current.date(byAdding: .day, value: 2, to: .distantPast)!,
            white: .exampleB,
            black: .exampleA
        )
    }

    static func seedExamples(amount: Int) -> [Game] {
        let games = Array(repeating: 0, count: amount)
        let randomNumbers = games.map { _ in arc4random() % 31 }
        return randomNumbers
            .map { amount in
                Game(
                    endTime: Calendar.current.date(byAdding: .day, value: Int(amount), to: .distantPast)!,
                    white: amount % 2 == 0 ? .exampleA : .exampleB,
                    black: amount % 2 == 0 ? .exampleB : .exampleA
                )
            }
    }
}
