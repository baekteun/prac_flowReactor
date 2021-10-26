//
//  baseTVC.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit

class baseTableViewCell<T>: UITableViewCell{
    let bound = UIScreen.main.bounds
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureCell(){}
    var model: T?{
        didSet{ if let model = model { bind(model) }}
    }
    func bind(_ model: T) {}
}
