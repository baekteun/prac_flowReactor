//
//  StepExtensions.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import RxFlow

extension Step{
    var asSampleStep: SampleStep?{
        return self as? SampleStep
    }
}
