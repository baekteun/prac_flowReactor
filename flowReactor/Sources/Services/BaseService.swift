//
//  BaseService.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//


class BaseService{
    unowned let provider: ServiceProviderType
    
    init(provider: ServiceProviderType){
        self.provider = provider
    }
}
