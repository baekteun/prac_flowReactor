//
//  HomeDetailVC.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import RxFlow
import RxCocoa
import ReactorKit
import Then
import SnapKit

final class HomeDetailVC: baseVC{
    // MARK: - Properties
    private let movieTitle: String
    internal var disposeBag: DisposeBag = .init()
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30)
        $0.textAlignment = .center
    }
    private let toMiddleButton = UIButton().then {
        $0.setTitle("toMiddle", for: .normal)
        $0.backgroundColor = .black
    }
    
    // MARK: - Init
    init(with reactor: HomeDetailReactor, title: String){
        self.movieTitle = title
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureVC() {
        super.configureVC()
        [titleLabel, toMiddleButton].forEach{view.addSubview($0)}
        titleLabel.text = movieTitle
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeArea.top)
            $0.bottom.equalTo(view.safeArea.bottom).inset(50)
        }
        toMiddleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeArea.bottom)
            $0.height.equalTo(50)
        }
    }
}


// MARK: - Extensions
// MARK: Reactor
extension HomeDetailVC: View{
    func bind(reactor: HomeDetailReactor) {
        toMiddleButton.rx.tap
            .map{Reactor.Action.toMiddleDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
