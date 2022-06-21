//
//  Schedule.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/15/22.
//

import Foundation

struct Schedule: Decodable {
    let date: String
    let games: [Game]
}
