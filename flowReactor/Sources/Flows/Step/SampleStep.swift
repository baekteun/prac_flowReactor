//
//  SampleStep.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import RxFlow

enum SampleStep: Step{
    // Global
    case alert(message: String)
    case dismiss
    
    // Login
    case loginIsRequired
    case loginIsCompleted
    
    // Main
    case mainTabbarIsRequired
    
    // Home
    case homeIsRequired
    case homeItemIsPicked(withID: String)
    
    // Middle
    case middleIsRequired
    case middledIsRequiredAgain
    case middleDetailIsRequired
    
    // Setting
    case settingIsRequired
    case settingAndAlertIsRequired(message: String)
}
