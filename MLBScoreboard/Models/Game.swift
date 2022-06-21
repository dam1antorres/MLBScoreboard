//
//  Game.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/15/22.
//

import Foundation

struct Game: Decodable {
    let gameDate: Date
    let status: GameStatus
    let teams: Match
    let linescore: Linescore?
    let venue: Venue
}
