//
//  Match.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/17/22.
//

import Foundation

struct Match: Decodable {
    let away: Team
    let home: Team
}

struct Team: Decodable {
    let score: Int?
    let team: TeamInfo
    let leagueRecord: Record
}

struct TeamInfo: Decodable {
    let teamName: String
    let abbreviation: String
}

struct Record: Decodable {
    let wins: Int
    let losses: Int
}
