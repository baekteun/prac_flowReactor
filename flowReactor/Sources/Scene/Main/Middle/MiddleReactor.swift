//
//  MiddleReactor.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import RxFlow
import RxCocoa
import ReactorKit

final class MiddleReactor: Reactor, Stepper{
    // MARK: - Stepper
    var steps: PublishRelay<Step> = .init()
    
    // MARK: - Events
    enum Action{
        case detailButtonDidTap
        case twoFlowButtonDidTap
    }
    enum Mutation{}
    struct State{}
    
    // MARK: - Properties
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType){
        initialState = State()
        self.provider = provider
    }
}

// MARK: - Extensions

// MARK: Mutation
extension MiddleReactor{
    func mutate(action: Action) -> Observable<Mutation> {
        switch action{
        case .detailButtonDidTap:
            steps.accept(SampleStep.middleDetailIsRequired)
            return .empty()
        case .twoFlowButtonDidTap:
            steps.accept(SampleStep.settingAndAlertIsRequired(message: "This is from middle towMiddleButton"))
            return .empty()
        }
    }
}
