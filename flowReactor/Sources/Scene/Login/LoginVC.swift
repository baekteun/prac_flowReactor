//
//  LoginVC.swift
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

final class LoginVC: baseVC{
    // MARK: - Properties
    var disposeBag: DisposeBag = .init()
    
    private let loginButton = UIButton().then{
        $0.setTitle("Login", for: .normal)
        $0.backgroundColor = .black
    }
    
    // MARK: - Init
    init(with reactor: LoginReactor){
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
        setUI()
    }
}

// MARK: - Extensions
// MARK: Method
private extension LoginVC{
    func setUI(){
        self.title = "Login"
        view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            $0.height.equalTo(50)
        }
        
    }
}

// MARK: Reactor
extension LoginVC: View{
    func bind(reactor: LoginReactor) {
        bindView(reactor)
        bindAction(reactor)
        bindState(reactor)
    }
    private func bindView(_ reactor: LoginReactor) {
        loginButton.rx.tap
            .map{ Reactor.Action.loginBtnDidTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindAction(_ reactor: LoginReactor) {}
    
    private func bindState(_ reactor: LoginReactor) {}
}
