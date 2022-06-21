//
//  Coordinating.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import UIKit

protocol Coordinating {
    func launch(in window: UIWindow)
    func handleSegue(_ segue: MLBSegue)
}
