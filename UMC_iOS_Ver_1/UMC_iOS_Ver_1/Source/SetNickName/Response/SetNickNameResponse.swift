//
//  SetNickNameResponse.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/14.
//

import Foundation

struct SetNickNameResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: String?
}

