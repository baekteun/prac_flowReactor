//
//  LoginReactor.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import RxFlow
import RxCocoa
import ReactorKit

final class LoginReactor: Reactor, Stepper{
    // MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Events
    enum Action{
        case loginBtnDidTap
    }
    
    enum Mutation{
        
    }
    struct State{
        
    }
    
    // MARK: - Properties
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType){
        self.provider = provider
        initialState = State()
    }
}

// MARK: - Extensions
// MARK: Mutation

extension LoginReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loginBtnDidTap:
            provider.loginService.setUserLogin()
            steps.accept(SampleStep.loginIsCompleted)
            return .empty()
        }
    }
}

// MARK: Reduce

extension LoginReactor{
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation{
        }
        return newState
    }
}

// MARK: Method

private extension LoginReactor{
    
}
