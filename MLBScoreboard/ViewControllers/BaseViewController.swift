//
//  BaseViewController.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Combine
import Foundation
import UIKit

class BaseViewController: UIViewController {
    let viewModel: ViewModel
    var bag: Set<AnyCancellable> = Set<AnyCancellable>()

    var shouldAllowInteractivePop: Bool {
        return true
    }

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
