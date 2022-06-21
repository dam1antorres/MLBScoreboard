//
//  Segues.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation

enum MLBSegue {
    case datePicker(DatePickerSegue)
    case gameDetail(GameDetailSegue)
}

enum DatePickerSegue {
    case chooseGameDate(Date)
    case close
}

enum GameDetailSegue {
    case detail(Game)
    case back
}
