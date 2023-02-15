//
//  ForumDataModel.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/02/11.
//

import Foundation
import Alamofire

struct ForumDataModel: Codable {
    let code, currentPage: Int
    let data: [ForumData]
    let isSuccess: Bool
    let message: String
    let totalPage: Int

    enum CodingKeys: String, CodingKey {
        case code
        case currentPage = "current_page"
        case data, isSuccess, message
        case totalPage = "total_page"
    }
}

struct ForumData: Codable {
    let comment: String
    let commentNum: Int
    let createDate: String
    let forumID: Int
    let forumImageURL: [String]
    let imageVideoNum: Int
    let forumInterviewIDSToRequests: [ForumInterviewIDSToRequest]
    let interviewNum, likeNum: Int
    let forumScriptIDToRequests: [ForumScriptIDToRequest]
    let scriptNum: Int
    let title, updateDate: String
    let userID: Int
    let writer: String

    enum CodingKeys: String, CodingKey {
        case comment
        case commentNum = "comment_num"
        case createDate
        case forumID = "forumId"
        case forumImageURL = "forumImage_url"
        case imageVideoNum = "image_video_num"
        case forumInterviewIDSToRequests = "interviewIdsToRequests"
        case interviewNum = "interview_num"
        case likeNum = "like_num"
        case forumScriptIDToRequests = "scriptIdToRequests"
        case scriptNum = "script_num"
        case title, updateDate
        case userID = "userId"
        case writer
    }
}

struct ForumInterviewIDSToRequest: Codable {
    let interviewID: Int

    enum CodingKeys: String, CodingKey {
        case interviewID = "interview_id"
    }
}

struct ForumScriptIDToRequest: Codable {
    let scriptID: Int

    enum CodingKeys: String, CodingKey {
        case scriptID = "script_id"
    }
}

var forumData: [ForumData] = []
