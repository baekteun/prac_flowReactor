//
//  SceneDelegate.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import RxFlow
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let coordinator: FlowCoordinator = .init()
    private let disposeBag: DisposeBag = .init()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let s = (scene as? UIWindowScene) else { return }
        
         coordinateLogStart()
        
        coordinateToAppFlow(with: s)
        
    }

    private func coordinateToAppFlow(with windowScene: UIWindowScene){
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let provider: ServiceProviderType = ServiceProvider()
        let appFlow = AppFlow(with: window, and: provider)
        let appStepper = AppStepper(provider: provider as! ServiceProvider)
        
        coordinator.coordinate(flow: appFlow, with: appStepper)
        
        window.makeKeyAndVisible()
    }
    
    private func coordinateLogStart(){
        coordinator.rx.willNavigate
            .subscribe(onNext: { flow, step in
                let currentFlow = "\(flow)".split(separator: ".").last ?? "No flow"
                print("➡️ will navigate to flow = \(currentFlow) and step = \(step)")
            })
            .disposed(by: disposeBag)
    }

}

