//
//  ScoreboardViewController.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/14/22.
//

import Combine
import Foundation
import Reusable
import SnapKit
import UIKit

class ScoreboardViewController: BaseViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.contentInset = .zero
        tableView.register(cellType: GameScoreCell.self)
        return tableView
    }()

    private let navigationBar = NavigationBar(style: .logo, showLeftButton: false)
    private let gameDatePicker = GameDateView()
    let scoreboardViewModel: ScoreboardViewModel

    init(viewModel: ScoreboardViewModel) {
        self.scoreboardViewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
        updateGameDatePicker(date: Date())
        scoreboardViewModel.fetchScoreboard(gameDate: .today)
    }

    private func setupSubviews() {
        navigationBar.install(in: view)
        view.addSubview(gameDatePicker)
        gameDatePicker.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.equalToSuperview()
        }
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(gameDatePicker.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func setupBindings() {
        scoreboardViewModel.$games
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &bag)

        scoreboardViewModel.$fetchError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .store(in: &bag)

        gameDatePicker
            .$tapped
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] tap in
                self?.scoreboardViewModel.handleDatePickerTap(tap: tap)
            })
            .store(in: &bag)

        scoreboardViewModel.$pickedDate
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink(receiveValue: { [weak self] date in
                guard let self = self else { return }
                self.updateGameDatePicker(date: date)
                self.scoreboardViewModel.fetchScoreboard(gameDate: date)
            })
            .store(in: &bag)
    }

    private func updateGameDatePicker(date: Date) {
        gameDatePicker.config = GameDateView.Config(gameDate: date)
    }
}

extension ScoreboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scoreboardViewModel.showGameDetail(game: scoreboardViewModel.games[indexPath.row])
    }
}

extension ScoreboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let _ = scoreboardViewModel.fetchError {
            self.tableView.setEmptyMessage("Strike Out!\nSomething's going on.")
        }
        else if scoreboardViewModel.games.count == 0 {
            self.tableView.setEmptyMessage("No take me out to the ball game today :(")
        } else {
            self.tableView.restore()
        }
        return scoreboardViewModel.games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameScoreCell.self)
        let viewModel = GameScoreCellViewModel(game: scoreboardViewModel.games[indexPath.row])
        cell.viewModel = viewModel
        return cell
    }
}
