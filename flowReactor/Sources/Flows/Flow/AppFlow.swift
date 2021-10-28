//
//  AppFlow.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import RxFlow
import RxCocoa
import RxSwift

struct AppStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    private let provider: ServiceProviderType
    private let disposeBag: DisposeBag = .init()
    
    init(provider: ServiceProvider){
        self.provider = provider
    }
    
    func readyToEmitSteps() {
        provider.loginService.didLoginObservable
            .map{ $0 ? SampleStep.loginIsCompleted : SampleStep.loginIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}

// Flow는 AnyObject를 준수하니 Class
final class AppFlow: Flow{
    var root: Presentable{
        return self.rootWindow
    }
    
    private let rootWindow: UIWindow
    private let provider: ServiceProviderType
    
    init(with window: UIWindow, and services: ServiceProviderType){
        self.rootWindow = window
        self.provider = services
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // 1. 바로 메인으로
    // 2. 로그인 필요
    // 3. 로그인 완료
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none}
        switch step{
        case .loginIsRequired:
            return coordinateToLoginVC()
            
        case .mainTabbarIsRequired, .loginIsCompleted:
            return coordinateMainVC()
        default:
            return .none
        }
    }
    
    private func coordinateToLoginVC() -> FlowContributors{
        let flow = LoginFlow(with: provider)
        
        Flows.use(flow, when: .created) { root in
            self.rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: SampleStep.loginIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: nextStep))
    }
    private func coordinateMainVC() -> FlowContributors{
        let flow = MainFlow(with: provider)
        Flows.use(flow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        let next = OneStepper(withSingleStep: SampleStep.mainTabbarIsRequired)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: next))
    }
}
