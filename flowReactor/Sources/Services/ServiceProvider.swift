//
//  ServiceProvider.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

protocol ServiceProviderType: class{
    var networkService: NetworkManagerType { get }
    var loginService: LoginServiceType { get }
}

final class ServiceProvider: ServiceProviderType{
    lazy var networkService: NetworkManagerType = NetworkManager()
    lazy var loginService: LoginServiceType = LoginService(provider: self)
}
