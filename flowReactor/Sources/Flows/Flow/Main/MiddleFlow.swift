//
//  MiddleFlow.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import UIKit
import RxFlow
import RxRelay

struct MiddleStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    var initialStep: Step{
        return SampleStep.middleIsRequired
    }
}
final class MiddleFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    private let rootVC = UINavigationController()
    let stepper: MiddleStepper
    private let provider: ServiceProviderType
    
    init(with services: ServiceProviderType, stepper: MiddleStepper){
        self.provider = services
        self.stepper = stepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none }
        switch step{
        case .middleIsRequired:
            return coordinateToMiddle()
            
        case .middledIsRequiredAgain:
            return coordinateToMiddleFirst()
            
        case .middleDetailIsRequired:
            return presentMiddleDetail()
            
        case let .settingAndAlertIsRequired(message):
            let step = SampleStep.settingAndAlertIsRequired(message: message)
            let contributor: FlowContributor = .forwardToParentFlow(withStep: step)
            return .one(flowContributor: contributor)
            
        case .dismiss:
            return dismissVC()
        default:
            return .none
            
        }
    }
}

// MARK: - Extensions

// MARK: Method
private extension MiddleFlow{
    func coordinateToMiddle() -> FlowContributors{
        let reactor = MiddleReactor(provider: provider)
        let vc = MiddleVC(with: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    func coordinateToMiddleFirst() -> FlowContributors{
        if (self.rootVC.viewControllers.first as? MiddleVC) != nil{
            return .none
        }else{
            return coordinateToMiddle()
        }
    }
    func presentMiddleDetail() -> FlowContributors{
        let reactor = MiddleDetailReactor(provider: provider)
        let vc = MiddleDetailVC(with: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    func dismissVC() -> FlowContributors{
        self.rootVC.visibleViewController?.dismiss(animated: true)
        return .none
    }
}
