//
//  Models.swift
//  flowReactor
//
//  Created by baegteun on 2021/10/26.
//

struct ResultBase{
    let metaData: MetaData
    let movie: [Movie]
}

struct MetaData{
    let isEnd: Bool
    let page: Int
}

struct Movie{
    let name: String
    let description: String
}
