//
//  HomeDetailReactor.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import RxFlow
import RxCocoa
import ReactorKit

final class HomeDetailReactor: Reactor, Stepper{
    // MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Events
    enum Action{
        case toMiddleDidTap
    }
    enum Mutation{}
    struct State {}
    
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

extension HomeDetailReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .toMiddleDidTap:
            steps.accept(SampleStep.middleIsRequired)
            return .empty()
        }
    }
}

