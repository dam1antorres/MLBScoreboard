//
//  DatePickerViewModel.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation

class DatePickerViewModel: ViewModel, ObservableObject {
    @Published var pickedDate: Date = Date()

    override init(coordinator: Coordinating) {
        super.init(coordinator: coordinator)
    }

    func close() {
        coordinator.handleSegue(.datePicker(.close))
    }
}
