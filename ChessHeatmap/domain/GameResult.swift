//
//  GameResult.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

enum GameResultSimplified {
    case win, loss, tie
}

enum GameResult: String, Codable {
    case win //Win
    case checkmated //Checkmated
    case agreed //Draw agreed
    case repetition //Draw by repetition
    case timeout //Timeout
    case resigned //Resigned
    case stalemate //Stalemate
    case lose //Lose
    case insufficient //Insufficient material
    case move50 //Draw by 50-move rule
    case abandoned //Abandoned
    case kingofthehill //Opponent king reached the hill
    case threecheck //Checked for the 3rd time
    case timevsinsufficient //Draw by timeout vs insufficient material
    case bughousepartnerlose //Bughouse partner lost

    var simplified: GameResultSimplified {
        switch self {
        case .win:
            return .win
        case .agreed, .repetition, .stalemate, .insufficient,
                .move50, .timevsinsufficient:
            return .tie
        case .checkmated, .timeout, .resigned, .lose, .abandoned, .kingofthehill,
                .threecheck, .bughousepartnerlose:
            return .loss
        }

    }

    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)

        if value == "50move" {
            self = .move50
        } else {
            self = .init(rawValue: value)!
        }
    }
}
