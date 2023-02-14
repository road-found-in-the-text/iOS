//
//  NetWorkingData.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/02/14.
//

import Foundation

class NetWorkingData {
    static let shared = NetWorkingData()
    
    let basicURL = "https://api.road-found-in-the-text-server.com"

    var totalPage = 0
    var numOfPage = 1

    private init() { }
}
