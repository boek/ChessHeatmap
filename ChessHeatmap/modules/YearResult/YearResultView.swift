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
    @State var results: OrderedGames?
    @State var searching = false
    @State var message: String? = nil
    @State private var availableYears: [Int] = []
    @State private var year: Int = Calendar.current.component(.year, from: Date())

    private func setupAvailableYears() {
        let currentYear = Calendar.current.component(.year, from: Date())
        availableYears = Array(2007...currentYear)
    }

    var body: some View {
        VStack {
            Text("Year View")
                .font(.custom("KaiseiDecol-Regular", size: 32))
                .padding(.top, 34)
                .padding(.bottom, 20)
            HStack (spacing: 13) {
                Text("Profiles")
                Text("Year View")
                Text("Compare")
                Text("Theme")
                Text("About")
            }
            Divider()
            VStack {
                VStack (alignment: .leading) {
                    Text("Username")
                    TextField("username", text: $username)
                        .padding(10)
                        .textInputAutocapitalization(.never)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                HStack {
                    Picker("Year", selection: $year) {
                        ForEach(availableYears, id: \.self) { year in
                            Text(String(year))
                                .tag(year)
                        }
                    }
                    Button("Search") {
                        searching = true
                    }.buttonStyle(.bordered)
                    
                }.padding(.vertical, 10)
                if let message {
                    Text(message)
                }
            }
            .padding()
            ScrollView {
                if let results {
                    HeatmapView(orderedGames: results)
                }
            }
        }.onAppear(perform: setupAvailableYears)
        .task(id: results) {
            guard let results else { return }
            var (wins, losses, ties) = results.gameList.reduce((0, 0, 0)) { results, game in
                var (wins, losses, ties) = results
                let result = game.white.player.username == username ? game.white.result : game.black.result
                switch result.simplified {
                case .win: wins += 1
                case .tie: ties += 1
                case .loss: losses += 1
                }
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
