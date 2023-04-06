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
    @State var month: Month = .april
    @State var results: [Game]?
    @State var searching = false

    var body: some View {
        List {
            if let results {
                ForEach(results, id: \.endTime) { game in
                    Text("\(game.white.username) vs \(game.black.username)")
                }
            }
        }.safeAreaInset(edge: .top) {
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

                Picker("Month", selection: $month) {
                    ForEach(Month.allCases, id: \.self) { month in
                        Text(month.display)
                            .tag(month)
                    }
                }

                Button("Find") {
                    searching = true
                }
            }
        }
        .task(id: searching) {
            guard searching else { return }
            do {
                var results = try await chessClient.fetchGames(.init(user: username, year: year, month: month))
                self.results = results
            } catch {
                print("something went wrong", error)
            }

        }
    }
}

struct YearResultView_Previews: PreviewProvider {
    static var previews: some View {
        YearResultView()
    }
}
