//
//  Environment+ChessClient.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import SwiftUI

struct ChessClientEnvironmentKey: EnvironmentKey {
    static var defaultValue: ChessClient { .test }
}

extension EnvironmentValues {
    var chessClient: ChessClient {
        get { self[ChessClientEnvironmentKey.self] }
        set { self[ChessClientEnvironmentKey.self] = newValue }
    }
}

extension View {
    func with(chessClient: ChessClient) -> some View {
        environment(\.chessClient, chessClient)
    }
}
