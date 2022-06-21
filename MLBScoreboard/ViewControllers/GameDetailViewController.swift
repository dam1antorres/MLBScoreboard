//
//  GameDetailViewController.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import UIKit

class GameDetailViewController: BaseViewController {

    private let gameDetailViewModel: GameDetailViewModel
    private let gameInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()

    private let matchLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()

    private let matchHourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()

    private var navigationBar: NavigationBar?

    init(viewModel: GameDetailViewModel) {
        self.gameDetailViewModel = viewModel
        super.init(viewModel: viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupBindings()
        setupInfoView()
    }

    private func setupSubviews() {
        let navBar = NavigationBar(style: .gameDetail(game: gameDetailViewModel.navBarGameDetail.game,
                                                      date: gameDetailViewModel.navBarGameDetail.date),
                                   showLeftButton: true)
        navigationBar = navBar
        navBar.install(in: view)

        view.addSubview(gameInfoStackView) { make in
            make.top.equalTo(navBar.snp.bottom).offset(12.0)
            make.centerX.equalToSuperview()
        }
        [matchLabel, matchHourLabel, locationLabel].forEach { gameInfoStackView.addArrangedSubview($0) }
    }

    private func setupBindings() {
        if let navigationBar = navigationBar {
            navigationBar.$tapped
                .receive(on: DispatchQueue.main)
                .dropFirst()
                .compactMap { $0 }
                .sink(receiveValue: { [weak self] tap in
                    switch tap {
                    case .back:
                        self?.gameDetailViewModel.backTapped()
                    }
                }).store(in: &bag)
        }
    }

    private func setupInfoView() {
        matchLabel.text = gameDetailViewModel.matchName
        matchHourLabel.text = gameDetailViewModel.matchHour
        locationLabel.text = gameDetailViewModel.location
    }
}
