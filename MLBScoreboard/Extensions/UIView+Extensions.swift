//
//  UIView+Extensions.swift
//  MLBScoreboard
//
//  Created by Damian Torres on 4/18/22.
//

import Foundation
import SnapKit
import UIKit

extension UIView {
    func addSubview(_ view: UIView, constraintsMaker: (ConstraintMaker) -> Void) {
        addSubview(view)
        view.snp.makeConstraints(constraintsMaker)
    }
}
