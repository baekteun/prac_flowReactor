//
//  SettingReactor.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import RxFlow
import RxCocoa
import ReactorKit

final class SettingReactor: Reactor, Stepper{
    // MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Events
    enum Action{
        case logoutButtonDidTap
        case alertButtonDidTap
    }
    enum Mutation{}
    struct State{}
    
    // MARK: - Properties
    let initialState: State
    let provider: ServiceProviderType
    
    // MARK: - Init
    init(provider: ServiceProviderType){
        initialState = State()
        self.provider = provider
    }
}

// MARK: - Extensions

// MARK: Mutation
extension SettingReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .logoutButtonDidTap:
            provider.loginService.setUserLogout()
            steps.accept(SampleStep.loginIsRequired)
            return .empty()
            
        case .alertButtonDidTap:
            steps.accept(SampleStep.alert(message: "From Setting"))
            return .empty()
        }
    }
}
