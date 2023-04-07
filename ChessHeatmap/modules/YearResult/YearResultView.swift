//
//  YearResultView.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import SwiftUI

struct YearResultView: View {
    @Environment(\.chessClient) var chessClient
    @State var username: String = ""
    @State var year: Int = 2023
    @State var results: OrderedGames?
    @State var searching = false
    @State var message: String? = nil

    var body: some View {
        VStack {
            VStack {
                TextField("username", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding()
                Picker("Year", selection: $year) {
                    ForEach(2007..<2024) { year in
                        Text(String(year))
                            .tag(year)
                    }
                }

                Button("Find") {
                    searching = true
                }

                if let message {
                    Text(message)
                }
            }
            Divider()
            ScrollView {
                if let results {
                    HeatmapView(orderedGames: results)
                }
            }
        }
        .task(id: results) {
            guard let results else { return }
            var (wins, losses, ties) = results.gameList.reduce((0, 0, 0)) { results, game in
                var (wins, losses, ties) = results
//                let result = game.white.username == username ? game.white.result : game.black.result
//                switch result.simplified {
//                case .win: wins += 1
//                case .tie: ties += 1
//                case .loss: losses += 1
//                }

                return (wins, losses, ties)
            }

            message = "\(username) has \(wins) wins, \(losses) losses and \(ties) draws"
        }
        .task(id: searching) {
            guard searching else { return }
            defer { searching = false }
            var results: [Game] = []
            for month in Month.allCases {

                print("finding games in month: \(month)")
                do {
                    results.append(contentsOf: try await chessClient.fetchGames(.init(user: username, year: year, month: month)))
                } catch { print("something went wrong", error) }
            }

            self.results = OrderedGames(games: results)
        }
    }
}

struct YearResultView_Previews: PreviewProvider {
    static var previews: some View {
        YearResultView()
    }
}
