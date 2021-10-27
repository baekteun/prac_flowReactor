//
//  MiddleDetailVC.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import UIKit
import Then
import SnapKit
import RxFlow
import ReactorKit
import RxCocoa

final class MiddleDetailVC: baseVC{
    // MARK: - Properties
    
    var disposeBag: DisposeBag = .init()
    
    private let dismissButton = UIButton().then {
        $0.setTitle("dismiss", for: .normal)
        $0.backgroundColor = .black
    }
    // MARK: - Init
    init(with reactor: MiddleDetailReactor){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Helpers
    override func configureVC() {
        super.configureVC()
        addView()
        setLayout()
    }
}

// MARK: - Extensions

// MARK: UI
private extension MiddleDetailVC{
    private func addView(){
        [dismissButton].forEach{view.addSubview($0)}
    }
    private func setLayout(){
        dismissButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview()
        }
    }
}

// MARK: Bind
extension MiddleDetailVC: View{
    func bind(reactor: MiddleDetailReactor) {
        dismissButton.rx.tap
            .map{Reactor.Action.dismissButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
