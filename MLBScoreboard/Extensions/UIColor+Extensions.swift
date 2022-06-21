//
//  UIColor+Extensions.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    static let mlbGray = UIColor(hex6: 0xf4f4f4)
}
