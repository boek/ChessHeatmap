//
//  OrderedGames.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

extension Date {
    var withoutTimestamp: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))!
    }

    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}

struct OrderedGames: Equatable {
    var gameList: [Game]
    var games: [Date: [Game]]
    var keys: [Date]
    var mostGamesInADay: Int
    var firstDate: Date
    var lastDate: Date
    var dateRange: [Date]

    init(games: [Game]) {
        self.gameList = games
        self.games = Dictionary(grouping: games, by: { $0.endTime.withoutTimestamp })
        self.keys = self.games.keys.sorted()
        self.firstDate = self.keys.first ?? Date()
        self.lastDate = self.keys.last ?? Date()
        self.dateRange = Date.dates(from: firstDate, to: lastDate)
        self.mostGamesInADay = self.games.values.reduce(0) { max($0, $1.count) }
    }

    subscript(date: Date) -> [Game] {
        self.games[date] ?? []
    }
}
