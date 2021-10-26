//
//  NetworkManager.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

import Foundation

protocol NetworkManagerType: class{
    func fetchMovies() -> Result<ResultBase, Error>
}

final class NetworkManager: NetworkManagerType{
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared){
        self.session = session
    }
    
    func fetchMovies() -> Result<ResultBase, Error> {
        let meta: MetaData = .init(isEnd: false, page: 10)
        
        let movies: [Movie] = [
            Movie(name: "ironMan", description: "아이언맨"),
            Movie(name: "SpiderMan", description: "스파이더맨"),
            Movie(name: "BatMan", description: "배트맨"),
            Movie(name: "SuperMan", description: "슈퍼맨"),
            Movie(name: "Thor", description: "토르"),
            Movie(name: "Hurk", description: "헐크"),
            Movie(name: "WonderWoman", description: "원더우먼"),
            Movie(name: "BlackPanther", description: "블랙팬서"),
            Movie(name: "Havi", description: "하비"),
            Movie(name: "Sangjin", description: "상진")
        ]
        
        let resultBase: ResultBase = ResultBase(metaData: meta, movie: movies)
        
        return .success(resultBase)
    }
}


protocol URLSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
