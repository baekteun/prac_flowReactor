//
//  MainFlow.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/28.
//

import UIKit
import RxSwift
import RxFlow

final class MainFlow: Flow{
    enum TabIndex: Int{
        case home = 0
        case middle = 1
        case setting = 2
    }
    
    var root: Presentable{
        return self.rootViewController
    }
    
    let rootViewController: UITabBarController = .init()
    private let provider: ServiceProviderType
    private let homeFlow: HomeFlow
    private let middleFlow: MiddleFlow
    private let settingFlow: SettingFlow
    
    init(with provider: ServiceProviderType){
        self.provider = provider
        self.homeFlow = .init(with: provider, stepper: .init())
        self.middleFlow = .init(with: provider, stepper: .init())
        self.settingFlow = .init(with: provider, stepper: .init())
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none }
        switch step{
        case .loginIsRequired:
            return .end(forwardToParentFlowWithStep: SampleStep.loginIsRequired)
        case .mainTabbarIsRequired:
            return coordinateToMainTabbar()
        case .middledIsRequiredAgain:
            return coordinateToMiddle(step: step)
        case .settingAndAlertIsRequired(message: let msg):
            return coordinateToSetting(with: msg)
            
        default:
            return .none
        }
    }
    private func coordinateToMainTabbar() -> FlowContributors{
        // 각각의 Flow들이 created 되었을때 tabbar에 세팅해준다
        
        
        Flows.use(
            homeFlow, middleFlow, settingFlow,
            when: .created
        ) { [unowned self](root1: UINavigationController,
                           root2: UINavigationController,
                           root3: UINavigationController) in
            let homeImage = UIImage(named: "home")
            let middleImage = UIImage(named: "middle")
            let settingImage = UIImage(named: "setting")
            let homeItem: UITabBarItem = .init(title: "Home", image: homeImage, selectedImage: nil)
            let middleItem: UITabBarItem = .init(title: "Middle", image: middleImage, selectedImage: nil)
            let settingItem: UITabBarItem = .init(title: "Setting", image: settingImage, selectedImage: nil)
            
            root1.tabBarItem = homeItem
            root2.tabBarItem = middleItem
            root3.tabBarItem = settingItem
            
            self.rootViewController.setViewControllers([root1, root2, root3], animated: true)
        }
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow, withNextStepper: homeFlow.stepper),
            .contribute(withNextPresentable: middleFlow, withNextStepper: middleFlow.stepper),
            .contribute(withNextPresentable: settingFlow, withNextStepper: settingFlow.stepper)
        ])
    }
    
    private func coordinateToMiddle(step: Step) -> FlowContributors{
        self.rootViewController.selectedIndex = TabIndex.middle.rawValue
        return .one(flowContributor: .contribute(withNextPresentable: middleFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.middledIsRequiredAgain)))
    }
    
    private func coordinateToSetting(with msg: String) -> FlowContributors{
        self.rootViewController.selectedIndex = TabIndex.setting.rawValue
        return .multiple(flowContributors: [
            .contribute(withNextPresentable: settingFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.settingIsRequired)),
            .contribute(withNextPresentable: settingFlow, withNextStepper: OneStepper(withSingleStep: SampleStep.alert(message: msg)))
        ])
    }
}
