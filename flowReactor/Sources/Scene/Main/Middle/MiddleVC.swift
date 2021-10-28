//
//  MiddleVC.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import UIKit
import RxFlow
import RxCocoa
import ReactorKit
import Then
import SnapKit

final class MiddleVC: baseVC{
    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    
    private let detailButton = UIButton().then {
        $0.setTitle("toMiddle", for: .normal)
        $0.backgroundColor = .black
    }
    
    private let twoDepthFlow = UIButton().then {
        $0.setTitle("twoDepthFlow", for: UIControl.State())
        $0.backgroundColor = .black
    }
    
    private let transitionButotn = UIButton().then {
        $0.setTitle("transitionButton", for: UIControl.State())
        $0.backgroundColor = .black
    }
    
    // MARK: - Init
    init(with reactor: MiddleReactor){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)):\(#function)")
    }
    
    // MARK: - Helpers
    override func configureVC() {
        super.configureVC()
        addView()
        setLayout()
    }
}

// MARK: - Extensions

// MARK: Bind
extension MiddleVC: View{
    func bind(reactor: MiddleReactor) {
        bindView(reactor)
    }
    private func bindView(_ reactor: MiddleReactor){
        detailButton.rx.tap
            .map{Reactor.Action.detailButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        twoDepthFlow.rx.tap
            .map{ Reactor.Action.twoFlowButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
}

// MARK: ConfigureVC
private extension MiddleVC{
    private func addView(){
        [detailButton, twoDepthFlow, transitionButotn].forEach{view.addSubview($0)}
    }
    private func setLayout(){
        detailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(view.safeArea.bottom).inset(50)
            $0.height.equalTo(50)
        }
        twoDepthFlow.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(detailButton.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
        transitionButotn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(twoDepthFlow.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
    }
}
