//
//  DatePickerViewController.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import SnapKit
import UIKit

class DatePickerViewController: BaseViewController {

    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return picker
    }()

    private let datePickerViewModel: DatePickerViewModel

    init(viewModel: DatePickerViewModel) {
        self.datePickerViewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }

    private func setupSubviews() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }

    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        datePickerViewModel.pickedDate = sender.date
        datePickerViewModel.close()
    }

}
