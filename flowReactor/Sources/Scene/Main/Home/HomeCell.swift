//
//  HomeCell.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import RxCocoa
import ReactorKit
import Then
import SnapKit

final class HomeCell: baseTableViewCell<Movie>{
    // MARK: - Properties
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    // MARK: - Helpers
    override func bind(_ model: Movie) {
        titleLabel.text = model.description
    }
    override func configureCell() {
        contentView.backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
    }
}


