//
//  GameStatus.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/17/22.
//

import Foundation

enum AbstractGameState: String, Decodable {
    case final = "Final"
    case preview = "Preview"
    case live = "Live"

    var printName: String {
        self.rawValue
    }
}

enum DetailedState: String, Decodable {
    case postponed = "Postponed"
    case final = "Final"
    case pregame = "Pre-Game"
    case warmup = "Warmup"
    case inprogress = "In Progress"
    case scheduled = "Scheduled"

    var printName: String {
        self.rawValue
    }
}

struct GameStatus: Decodable {
    let abstractGameState: AbstractGameState
    let detailedState: DetailedState

    public enum CodingKeys: String, CodingKey {
        case abstractGameState
        case detailedState
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abstractGameState = (try? values.decode(AbstractGameState.self, forKey: .abstractGameState)) ?? .preview
        detailedState = (try? values.decode(DetailedState.self, forKey: .detailedState)) ?? .scheduled
    }
}
