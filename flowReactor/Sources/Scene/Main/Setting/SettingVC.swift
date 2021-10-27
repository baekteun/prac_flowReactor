//
//  SettingVC.swift
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

final class SettingVC: baseVC{
    // MARK: - Properties
    
    var disposeBag: DisposeBag = .init()
    
    private let logoutButton = UIButton().then {
        $0.setTitle("logout", for: .normal)
        $0.backgroundColor = .black
    }
    
    private let alertButton = UIButton().then {
        $0.setTitle("showAlert", for: UIControl.State())
        $0.backgroundColor = .black
    }
    
    // MARK: - Helpers
    override func configureVC() {
        super.configureVC()
        self.title = "Setting"
        view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        addView()
        setLayout()
    }
    
    // MARK: - Init
    init(with reactor: SettingReactor){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
}

// MARK: - Extensions

// MARK: Bind
extension SettingVC: View{
    func bind(reactor: SettingReactor) {
        bindView(reactor)
    }
    private func bindView(_ reactor: SettingReactor){
        logoutButton.rx.tap
            .map{Reactor.Action.logoutButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        alertButton.rx.tap
            .map{Reactor.Action.alertButtonDidTap}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}

// MARK: UI
private extension SettingVC{
    private func addView(){
        [logoutButton, alertButton].forEach{view.addSubview($0)}
    }
    private func setLayout(){
        logoutButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(view.safeArea.bottom).inset(50)
            $0.height.equalTo(50)
        }
        alertButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalTo(logoutButton.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
    }
}
