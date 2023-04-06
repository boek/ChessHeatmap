//
//  ChessClient.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

enum Month: Int, CaseIterable {
    case january = 1
    case febuary
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december

    var display: String {
        switch self {
        case .january: return "january"
        case .febuary: return "febuary"
        case .march: return "march"
        case .april: return "april"
        case .may: return "may"
        case .june: return "june"
        case .july: return "july"
        case .august: return "august"
        case .september: return "september"
        case .october: return "october"
        case .november: return "november"
        case .december: return "december"
        }
    }
}

struct FetchGamesOptions {
    var user: String
    var year: Int
    var month: Month
}

struct ChessClient {
    var fetchGames: (FetchGamesOptions) async throws -> [Game]
}

struct GamesResult: Codable {
    var games: [Game]
}

extension ChessClient {
    static var test: Self {
        .init(
            fetchGames: { _ in [] }
        )
    }

    static var live: Self {
        .init(
            fetchGames: { options in
                guard let request = URL(string: "https://api.chess.com/pub/player/\(options.user)/games/\(options.year)/\(String(format: "%02d", options.month.rawValue))")
                    .map({ URLRequest(url: $0) }) else { fatalError() }
                print(request)
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                let result = try decoder.decode(GamesResult.self, from: data)
                print("-------", result)
                return result.games
            }
        )
    }
}
