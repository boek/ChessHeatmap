//
//  ChessHeatmapApp.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import SwiftUI

@main
struct ChessHeatmapApp: App {
    var body: some Scene {
        WindowGroup {
            YearResultView()
                .with(chessClient: .live)
                .environment(\.font, Font.custom("KaiseiDecol-Regular", size: 15))
        }
    }
}
