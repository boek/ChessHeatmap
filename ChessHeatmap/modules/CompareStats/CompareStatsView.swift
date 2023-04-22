//
//  CompareStatsView.swift
//  ChessHeatmap
//
//  Created by Maxwell DeMaio on 4/21/23.
//

import SwiftUI

struct CompareStatsView: View {
    @Environment(\.chessClient) var chessClient
    @State var username1: String = ""
    @State var username2: String = ""
    @State var results1: OrderedGames?
    @State var results2: OrderedGames?
    @State var message1: String? = nil
    @State var message2: String? = nil
    @State var searching = false
    @State private var availableYears: [Int] = []
    @State private var year: Int = Calendar.current.component(.year, from: Date())
    
    var isFormValid: Bool {
        !username1.isEmpty && !username2.isEmpty
    }
    
    private func setupAvailableYears() {
        let currentYear = Calendar.current.component(.year, from: Date())
        availableYears = Array(2007...currentYear)
    }
    
    var body: some View {
        VStack {
            HStack{
                VStack (alignment: .leading) {
                    Text("Username1")
                    TextField("username1", text: $username1)
                        .padding(10)
                        .textInputAutocapitalization(.never)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                VStack (alignment: .leading) {
                    Text("Username2")
                    TextField("username2", text: $username2)
                        .padding(10)
                        .textInputAutocapitalization(.never)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }.padding()
            
            HStack {
                Picker("Year", selection: $year) {
                    ForEach(availableYears, id: \.self) { year in
                        Text(String(year))
                            .tag(year)
                    }
                }
                Button("Compare") {
                    searching = true
                }
                .buttonStyle(.bordered)
                .disabled(!isFormValid)
                
            }
            .onAppear(perform: setupAvailableYears)
            .padding(.vertical, 10)
            HStack {
                VStack {
                    if let message1 {
                        Text(message1)
                    }
                    ScrollView {
                        if let results1 {
                            HeatmapView(orderedGames: results1)
                        }
                    }
                }
                VStack {
                    if let message2 {
                        Text(message2)
                    }
                    ScrollView {
                        if let results2 {
                            HeatmapView(orderedGames: results2)
                        }
                    }
                }
                
            }
            
        }
        .task(id: searching) {
            guard searching else { return }
            defer { searching = false }

            // Fetch games for username1
            var results1: [Game] = []
            for month in Month.allCases {
                print(username1)
                print(year)
                print(month)
                print("finding games in month: \(month)")
                do {
                    results1.append(contentsOf: try await chessClient.fetchGames(.init(user: username1, year: year, month: month)))
                } catch { print("something went wrong", error) }
            }

            // Fetch games for username2
            var results2: [Game] = []
            for month in Month.allCases {
                print(username2)
                print(year)
                print(month)
                print("finding games in month: \(month)")
                do {
                    results2.append(contentsOf: try await chessClient.fetchGames(.init(user: username2, year: year, month: month)))
                } catch { print("something went wrong", error) }
            }

            // Set the results and message for both usernames
            self.results1 = OrderedGames(games: results1)
            self.results2 = OrderedGames(games: results2)

            var (wins1, losses1, ties1) = results1.reduce((0, 0, 0)) { results1, game in
                var (wins, losses, ties) = results1
                let result = game.white.player.username == username1 ? game.white.result : game.black.result
                switch result.simplified {
                case .win: wins += 1
                case .tie: ties += 1
                case .loss: losses += 1
                }
                return (wins, losses, ties)
            }

            var (wins2, losses2, ties2) = results2.reduce((0, 0, 0)) { results2, game in
                var (wins, losses, ties) = results2
                let result = game.white.player.username == username2 ? game.white.result : game.black.result
                switch result.simplified {
                case .win: wins += 1
                case .tie: ties += 1
                case .loss: losses += 1
                }
                return (wins, losses, ties)
            }

            message1 = "\(username1) has \(wins1) wins, \(losses1) losses and \(ties1) draws"
            message2 = "\(username2) has \(wins2) wins, \(losses2) losses and \(ties2) draws"
        }
    }
    
}

struct CompareStatsView_Previews: PreviewProvider {
    static var previews: some View {
        CompareStatsView()
    }
}
