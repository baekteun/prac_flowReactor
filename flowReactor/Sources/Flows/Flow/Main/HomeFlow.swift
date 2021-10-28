//
//  HomeFlow.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import UIKit
import RxFlow
import RxRelay

struct HomeStepper: Stepper{
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step{
        return SampleStep.homeIsRequired
    }
}

final class HomeFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    
    let stepper: HomeStepper
    private let provider: ServiceProviderType
    private let rootVC = UINavigationController()
    
    // MARK: - Init
    init(with services: ServiceProviderType, stepper: HomeStepper){
        self.provider = services
        self.stepper = stepper
    }
    
    deinit{
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none }
        switch step{
        case .homeIsRequired:
            return coordinateToHome()
            
        case let .homeItemIsPicked(withID):
            return coordinateToHomeDetail(with: withID)
            
        case .middledIsRequiredAgain:
            return .one(flowContributor: .forwardToParentFlow(withStep: SampleStep.middledIsRequiredAgain))
            
        default:
            return .none
        }
    }
}

// MARK: - Extensions

// MARK: Method
private extension HomeFlow{
    func coordinateToHome() -> FlowContributors{
        let reactor = HomeReactor(provider: provider)
        let vc = HomeVC(with: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    func coordinateToHomeDetail(with ID: String) -> FlowContributors{
        let reactor = HomeDetailReactor(provider: provider)
        let vc = HomeDetailVC(with: reactor, title: ID)
        self.rootVC.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
}
