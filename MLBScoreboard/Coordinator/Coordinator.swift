//
//  Coordinator.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/15/22.
//

import Combine
import Foundation
import UIKit

class Coordinator: Coordinating {

    private var contentViewController: UIViewController?
    private var mainNavigationController: UINavigationController? {
        return contentViewController as? UINavigationController
    }

    private var scoreboardViewModel: ScoreboardViewModel? {
        (mainNavigationController?.viewControllers.first as? ScoreboardViewController)?.scoreboardViewModel
    }

    private var bag: Set<AnyCancellable> = Set<AnyCancellable>()

    func launch(in window: UIWindow) {
        setupAppearance()
        contentViewController = UINavigationController(rootViewController: ScoreboardViewController(viewModel: ScoreboardViewModel(coordinator: self)))
        window.rootViewController = contentViewController
    }

    private func setupAppearance() {
        let navBarAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        navBarAppearance.prefersLargeTitles = false
        navBarAppearance.isTranslucent = true
        navBarAppearance.setBackgroundImage(UIImage(), for: .default)
        navBarAppearance.barTintColor = .white
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.backIndicatorImage = UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal)
    }

    func handleSegue(_ segue: MLBSegue) {
        switch segue {
        case .datePicker(let segue): handleDatePickerSegue(segue)
        case .gameDetail(let segue): handleGameDetailSegue(segue)
        }
    }

    private func handleDatePickerSegue(_ segue: DatePickerSegue) {
        switch segue {
        case .chooseGameDate(_):
            showDatePicker()
        case .close:
            mainNavigationController?.dismiss(animated: true)
        }
    }

    private func handleGameDetailSegue(_ segue: GameDetailSegue) {
        switch segue {
        case .detail(let game):
            showGameDetail(game: game)
        case .back:
            mainNavigationController?.popViewController(animated: true)
        }
    }

    private func showDatePicker() {
        let viewModel = DatePickerViewModel(coordinator: self)
        if let scoreboardViewModel = scoreboardViewModel {
            viewModel.$pickedDate
                .receive(on: DispatchQueue.main)
                .assign(to: \.pickedDate, on: scoreboardViewModel)
                .store(in: &bag)
        }
        let pickerViewController = DatePickerViewController(viewModel: viewModel)
        mainNavigationController?.present(pickerViewController, animated: true)
    }

    private func showGameDetail(game: Game) {
        let viewModel = GameDetailViewModel(game: game, coordinator: self)
        let viewController = GameDetailViewController(viewModel: viewModel)
        mainNavigationController?.pushViewController(viewController, animated: true)
    }
}
