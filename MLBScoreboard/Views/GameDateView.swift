//
//  GameDateView.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import UIKit

class GameDateView: UIView {

    struct Config {
        let gameDate: Date
    }

    enum Tap {
        case gameButton, forward, back
    }

    private let leftChevron: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        return button
    }()
    private let rightChevron: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        return button
    }()
    private let dateButton = UIButton()

    @Published var tapped: Tap? = nil

    private let dateFormatter = DateFormatter()

    var config: Config? {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupBindings()
        backgroundColor = .mlbGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(leftChevron)
        addSubview(dateButton)
        addSubview(rightChevron)

        leftChevron.contentMode = .scaleAspectFit
        rightChevron.contentMode = .scaleAspectFit
        leftChevron.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.0)
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().offset(-8.0)
        }
        dateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().offset(-8.0)
        }
        rightChevron.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-8.0)
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().offset(-8.0)
        }
    }

    private func setupBindings() {
        dateButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        rightChevron.addTarget(self, action: #selector(rightChevronTapped), for: .touchUpInside)
        leftChevron.addTarget(self, action: #selector(leftChevronTapped), for: .touchUpInside)
    }

    private func updateUI() {
        dateButton.setAttributedTitle(nil, for: .normal)
        guard let config = config else { return }
        dateButton.setAttributedTitle(dateFrom(config.gameDate), for: .normal)
    }

    private func dateFrom(_ date: Date) -> NSAttributedString {
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "LLLL dd"
        let today =  dateFormatter.string(from: date)

        let attr = NSMutableAttributedString(string: "\(day) \(today)")
        attr.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18, weight: .bold),
                          range: NSMakeRange(day.count, today.count + 1))
        return attr
    }

    @objc private func buttonTapped() {
        tapped = .gameButton
    }

    @objc private func rightChevronTapped() {
        tapped = .forward
    }

    @objc private func leftChevronTapped() {
        tapped = .back
    }

}
