//
//  Database.swift
//  ChessHeatmap
//
//  Created by Jeff Boek on 4/6/23.
//

import Foundation
import SQLite

// MARK: Constants
let sqlitePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension("data.sqlite")

struct DatabaseClient {
    var db: Connection

}

