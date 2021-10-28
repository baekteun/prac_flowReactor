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
}
