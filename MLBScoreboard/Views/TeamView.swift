//
//  TeamView.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/15/22.
//

import Foundation
import SnapKit
import UIKit

class TeamView: UIView {

    struct Config {
        let name: String
        let record: String
    }

    let name = UILabel()
    let record: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        return label
    }()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    var config: Config? {
        didSet {
            updateUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12.0)
            make.top.equalToSuperview().offset(8.0)
            make.bottom.equalToSuperview().offset(-8.0)
        }
        [name, record].forEach { stackView.addArrangedSubview($0) }
    }

    private func updateUI() {
        guard let config = config else {
            return
        }
        name.text = config.name
        record.text = config.record
    }
}
