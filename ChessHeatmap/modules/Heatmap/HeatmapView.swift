//
//  HeatmapView.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import SwiftUI

struct HeatmapView: View {
    var orderedGames: OrderedGames

    let columns = [
        GridItem(.fixed(40), spacing: 4),
        GridItem(.fixed(40), spacing: 4),
        GridItem(.fixed(40), spacing: 4),
        GridItem(.fixed(40), spacing: 4),
        GridItem(.fixed(40), spacing: 4),
        GridItem(.fixed(40), spacing: 4),
        GridItem(.fixed(40), spacing: 4)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 3) {
            ForEach(orderedGames.keys, id: \.self) { key in
                Rectangle()
                    .foregroundColor(.green)
                    .aspectRatio(contentMode: .fit)
                    .opacity(Double(orderedGames[key].count) / Double(orderedGames.mostGamesInADay))
                    .overlay {
                        Rectangle()
                            .stroke(Color.green)
                    }
            }
        }
    }
}

struct HeatmapView_Previews: PreviewProvider {
    static var previews: some View {
        Text("test")
//        HeatmapView(orderedGames: examples)
    }
}
