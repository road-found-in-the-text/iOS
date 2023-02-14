//
//  NormalSignupResponse.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/10.
//

import Foundation

struct NormalSignupResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: normalUserInfo?
}

// MARK: - DataClass
struct normalUserInfo: Codable {
    let memberID: Int
    let jwt: String

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case jwt
    }
}
