//
//  PostCommentDataModel.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/26.
//

import Foundation

struct PostCommentDataModel: Codable {
    let code: Int
    let data: [PostCommentData]
    let isSuccess: Bool
    let message: String
    let totalPage: Int
    let currentPage: Int
    
    enum CodingKeys: String, CodingKey {
        case code
        case data
        case isSuccess
        case message
        case totalPage = "total_page"
        case currentPage = "current_page"
    }
}

struct PostCommentData: Codable {
    let forumId: Int
    let commentId: Int
    let writerId: Int
    let writer: String
    let content: String
    let likeNum: Int
    let nestedCommentDatas: [NestedCommentData]
}

struct NestedCommentData: Codable {
    let commentId: Int
    let nestedCommentId: Int
    let writerId: Int
    let writer: String
    let content: String
    let likeNum: Int
}
