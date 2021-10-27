//
//  MiddleDetailReactor.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import RxFlow
import RxCocoa
import ReactorKit

final class MiddleDetailReactor: Reactor, Stepper{
    // MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Events
    enum Action{
        case dismissButtonDidTap
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
extension MiddleDetailReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .dismissButtonDidTap:
            steps.accept(SampleStep.dismiss)
            return .empty()
        }
    }
}
