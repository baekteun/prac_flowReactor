//
//  UICellExtensions.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit

protocol ReuseIdentifiable {
    static var reusableID: String { get }
}

extension ReuseIdentifiable {
    static var reusableID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
extension UICollectionViewCell: ReuseIdentifiable {}
