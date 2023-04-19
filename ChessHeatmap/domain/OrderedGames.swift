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
        self.mostGamesInADay = self.games.values.reduce(0) { max($0, $1.count) }
        self.keys = self.games.keys.sorted()
        self.firstDate = self.keys.first ?? Date()
        self.lastDate = self.keys.last ?? Date()
        
        // Create date range for the full year based on firstDate
        let calendar = Calendar.current
        let year = calendar.component(.year, from: firstDate)
        let startDate = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
        let endDate = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
        self.dateRange = Date.dates(from: startDate, to: endDate)
        
        // Merge in empty games for missing dates
        self.keys = self.dateRange
        for date in self.dateRange {
            if let _ = self.games[date] {
                continue
            }
            self.games[date] = []
        }
    }

    subscript(date: Date) -> [Game] {
        self.games[date] ?? []
    }
}
