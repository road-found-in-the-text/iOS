//
//  Member.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/14.
//

import Foundation

struct Member: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: MemberData
}

struct MemberData: Codable {
    let createdAt: String?
    let updateAt: String?
    let id: Int
    let socialId: String
    let email: String
    let nickName: String?
    let imageUrl: String?
    let tier: String
    let loginType: String
    let introduction: String?
    let memberStatus: Int
    let blockStatus: Int
}
