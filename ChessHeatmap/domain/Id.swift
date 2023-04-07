//
//  Id.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation

enum ID<T: Equatable & Codable>: Equatable, Codable {
    case none
    case notPersisted(T)
    case persisted(T)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(T.self)
        self = .notPersisted(value)
    }
}
