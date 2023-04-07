//
//  Database.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation
import SQLite

struct UserClient {
    var get: (String) async throws -> Player
}

extension UserClient {
    static var test: Self {
        .init { _ in .test }
    }

    static func live(
        database: Database,
        chessClient: ChessClient
    ) -> Self {
        .init(get: { user in
            try await chessClient.fetchPlayer(user)
        })
    }
}



