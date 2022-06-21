//
//  GameDetailViewModel.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation

class GameDetailViewModel: ViewModel {
    private let game: Game

    var navBarGameDetail: (game: String, date: String) {
        return (game: abbreviatedGameDetail, gameDate)
    }

    var abbreviatedGameDetail: String {
        "\(game.teams.away.team.abbreviation) @ \(game.teams.home.team.abbreviation)"
    }

    var matchName: String {
        guard let awayScore = game.teams.away.score,
              let homeTeamScore = game.teams.home.score,
              game.status.abstractGameState == .final else {
            return "\(game.teams.away.team.teamName) @ \(game.teams.home.team.teamName)"
        }
        return "\(game.teams.away.team.teamName) \(String(awayScore)) @ \(game.teams.home.team.teamName) \(String(homeTeamScore))"
    }

    var matchHour: String {
        statusDateFormatter.string(from: game.gameDate)
    }

    var location: String {
        "\(game.venue.name) • \(game.venue.location.city), \(game.venue.location.country)"
    }

    var gameDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: game.gameDate)
    }

    private let statusDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a zz"
        dateFormatter.timeZone = TimeZone(abbreviation: "ET")
        return dateFormatter
    }()

    init(game: Game, coordinator: Coordinator) {
        self.game = game
        super.init(coordinator: coordinator)
    }

    func backTapped() {
        coordinator.handleSegue(.gameDetail(.back))
    }
}
