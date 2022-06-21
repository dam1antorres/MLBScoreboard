//
//  GameScoreCellViewModel.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/17/22.
//

import Foundation

class GameScoreCellViewModel {

    private let game: Game
    private let statusDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a zz"
        dateFormatter.timeZone = TimeZone(abbreviation: "ET")
        return dateFormatter
    }()

    var awayTeamName: String {
        game.teams.away.team.teamName
    }

    var homeTeamName: String {
        game.teams.home.team.teamName
    }

    var awayTeamRecord: String {
        "\(game.teams.away.leagueRecord.wins) - \(game.teams.away.leagueRecord.losses)"
    }

    var homeTeamRecord: String {
        "\(game.teams.home.leagueRecord.wins) - \(game.teams.home.leagueRecord.losses)"
    }

    var awayTeamScore: Int? {
        game.teams.away.score
    }

    var homeTeamScore: Int? {
        game.teams.home.score
    }

    var gameStatus: String {
        if game.status.abstractGameState == .final {
            if let inning = game.linescore?.currentInning, inning != 9 {
                return "F/\(String(inning))"
            }
            else if game.status.detailedState == .postponed {
                return game.status.detailedState.printName
            }
            else {
                return game.status.abstractGameState.printName
            }
        } else if game.status.abstractGameState == .preview {
            let gameHour = statusDateFormatter.string(from: game.gameDate)
            return gameHour
        } else if let inning = game.linescore?.currentInningPrintName {
            return String(inning)
        }
        return ""
    }

    init(game: Game) {
        self.game = game
    }
}
