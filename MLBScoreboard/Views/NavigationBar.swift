//
//  NavigationBar.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import SnapKit
import UIKit

class NavigationBar: UIView {

    enum Style {
        case logo, gameDetail(game: String, date: String)
    }

    enum Tap {
        case back
    }

    @Published var tapped: Tap? = nil

    private let containerView = UIView()
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    private let gameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    private let gameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    private let gameDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 8.0)
        return label
    }()
    private let logoImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let showLeftButton: Bool
    private let style: Style

    private static let height = CGFloat(44.0)

    init(style: Style, showLeftButton: Bool = false) {
        self.style = style
        self.showLeftButton = showLeftButton
        super.init(frame: .zero)
        setupSubviews()
        setupBindings()
        backgroundColor = .mlbGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func install(in view: UIView) {
        view.addSubview(self) { $0.top.left.right.equalToSuperview() }
        containerView.snp.makeConstraints { $0.top.equalTo(view.safeAreaLayoutGuide) }
    }

    private func setupSubviews() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(NavigationBar.height)
        }
        switch style {
        case .logo:
            containerView.addSubview(logoImageView)
            logoImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8.0)
                make.bottom.equalToSuperview().offset(-8.0)
                make.centerX.equalToSuperview()
            }
        case .gameDetail(let game, let date):
            containerView.addSubview(gameStack) { make in
                make.top.equalToSuperview().offset(8.0)
                make.bottom.equalToSuperview().offset(-8.0)
                make.centerX.equalToSuperview()
            }
            [gameLabel, gameDateLabel].forEach { gameStack.addArrangedSubview($0) }
            gameLabel.text = game
            gameDateLabel.text = date
        }
        if showLeftButton {
            containerView.addSubview(backButton) { make in
                make.left.equalToSuperview().offset(14.0)
                make.top.bottom.equalToSuperview()
            }
        }
    }

    private func setupBindings() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        tapped = .back
    }
}
