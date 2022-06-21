//
//  Linescore.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation

struct Linescore: Decodable {
    let currentInning: Int?
    let innings: [Inning]?
}

extension Linescore {
    var currentInningPrintName: String {
        guard let currentInning = currentInning else { return "" }
        switch currentInning {
        case 1:
            return "\(currentInning)st"
        case 2:
            return "\(currentInning)nd"
        case 3:
            return "\(currentInning)rd"
        case 4...:
            return "\(currentInning)th"
        default:
            return ""
        }
    }
}

struct Inning: Decodable {
    let num: Int?
    let home: Stat?
    let away: Stat?
}

struct Stat: Decodable {
    let runs: Int?
    let hits: Int?
    let errors: Int?
}

