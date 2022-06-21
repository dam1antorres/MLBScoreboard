//
//  ScoreboardViewModel.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/14/22.
//

import Combine
import Foundation

class ScoreboardViewModel: ViewModel, ObservableObject {

    private let api = API()
    @Published var games: [Game] = []
    @Published var pickedDate: Date = Date()
    @Published var fetchError: Error?

    func fetchScoreboard(gameDate: Date) {
        Task {
            do {
                let scoreboard = try await api.fetchScoreboard(date: gameDate)
                if let games = scoreboard.first?.dates.first?.games {
                    self.games = games.sorted { game1, game2 in
                        game1.gameDate > game2.gameDate
                    }
                }
            } catch {
                fetchError = error
            }
        }
    }

    func showDatePicker() {
        coordinator.handleSegue(.datePicker(.chooseGameDate(pickedDate)))
    }

    func showGameDetail(game: Game) {
        coordinator.handleSegue(.gameDetail(.detail(game)))
    }

    func handleDatePickerTap(tap: GameDateView.Tap) {
        switch tap {
        case .gameButton:
            showDatePicker()
        case .back:
            pickedDate = Calendar.current.date(byAdding: .day, value: -1, to: pickedDate) ?? Date()
        case .forward:
            pickedDate = Calendar.current.date(byAdding: .day, value: 1, to: pickedDate) ?? Date()
        }
    }
}
