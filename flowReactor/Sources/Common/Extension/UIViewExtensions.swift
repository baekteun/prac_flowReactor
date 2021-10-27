//
//  UIViewExtensions.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import SnapKit

extension UIView {
    var safeArea: ConstraintLayoutGuideDSL {
        return safeAreaLayoutGuide.snp
    }
}
