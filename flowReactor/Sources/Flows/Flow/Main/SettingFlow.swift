//
//  SettingFlow.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import UIKit
import RxFlow
import RxRelay

struct SettingStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return SampleStep.settingIsRequired
    }
}
final class SettingFlow: Flow{
    // MARK: - Properties
    var root: Presentable{
        return self.rootVC
    }
    private let rootVC = UINavigationController()
    let stepper: SettingStepper
    private let provider: ServiceProviderType
    
    // MARK: - Init
    init(with services: ServiceProviderType, stepper: SettingStepper){
        self.provider = services
        self.stepper = stepper
    }
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: - Navigate
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return }
        
    }
}

// MARK: - Extensions

// MARK: Method
private extension SettingFlow{
    func coordinateToSetting() -> FlowContributors{
        let reactor = SettingReactor(provider: provider)
        let vc = SettingVC(with: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    func coordinateToLogin() -> FlowContributors{
        let reactor = LoginReactor(provider: provider)
        let vc = LoginVC(with: reactor)
        self.rootVC.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, withNextStepper: reactor))
    }
    
    func navigateToAlertScreen(message: String) -> FlowContributors{
        let alert = UIAlertController(title: "demo", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        rootVC.present(alert, animated: true)
        return .none
    }
}
