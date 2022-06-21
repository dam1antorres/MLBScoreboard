//
//  GameScoreCell.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/15/22.
//

import Foundation
import Reusable
import SnapKit

class GameScoreCell: UITableViewCell, Reusable {
    private let awayTeam = TeamView()
    private let homeTeam = TeamView()
    private let scoreStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    private let matchStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    private let awayTeamScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    private let homeTeamScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0 )
        return label
    }()
    private let gameStatus: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private let chevron = UIImageView(image: UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal))

    var viewModel: GameScoreCellViewModel? {
        didSet {
            updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(matchStackView)
        matchStackView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        [awayTeam, homeTeam].forEach { matchStackView.addArrangedSubview($0) }

        contentView.addSubview(scoreStack)
        scoreStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().offset(-8.0)
            make.centerX.equalToSuperview()
        }
        [awayTeamScore, homeTeamScore].forEach { scoreStack.addArrangedSubview($0) }

        contentView.addSubview(gameStatus)
        contentView.addSubview(chevron)
        chevron.contentMode = .scaleAspectFit
        chevron.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8.0)
            make.right.equalToSuperview().offset(-12.0)
        }
        gameStatus.snp.makeConstraints { make in
            make.right.equalTo(chevron.snp.left).offset(-4.0)
            make.top.equalTo(chevron.snp.top)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        awayTeam.config = TeamView.Config(name: "", record: "")
        homeTeam.config = TeamView.Config(name: "", record: "")
        awayTeamScore.text = ""
        homeTeamScore.text = ""
        gameStatus.text = ""
    }

    private func updateUI() {
        guard let viewModel = viewModel else { return }
        awayTeam.config = TeamView.Config(name: viewModel.awayTeamName, record: viewModel.awayTeamRecord)
        homeTeam.config = TeamView.Config(name: viewModel.homeTeamName, record: viewModel.homeTeamRecord)
        if let awayScore = viewModel.awayTeamScore, let homeScore = viewModel.homeTeamScore {
            awayTeamScore.text = String(awayScore)
            homeTeamScore.text = String(homeScore)
        }
        gameStatus.text = viewModel.gameStatus
    }
}
