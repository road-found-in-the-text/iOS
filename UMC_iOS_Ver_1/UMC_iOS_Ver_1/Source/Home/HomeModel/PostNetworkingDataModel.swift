//
//  PostNetworkingDataModel.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/02/15.
//

import Foundation

struct PostDataModel: Codable {
    let code: Int
    let data: PostData
    let isSuccess: Bool
    let message: String
}

struct PostData: Codable {
    let comment: String
    let commentNum: Int
    let createDate: String
    let forumID: Int
    let forumImageURL: [String]
    let imageVideoNum: Int
    let postInterviewIDSToRequests: [PostInterviewIDSToRequest]
    let interviewNum, likeNum: Int
    let postScriptIDToRequests: [PostScriptIDToRequest]
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
        case postInterviewIDSToRequests = "interviewIdsToRequests"
        case interviewNum = "interview_num"
        case likeNum = "like_num"
        case postScriptIDToRequests = "scriptIdToRequests"
        case scriptNum = "script_num"
        case title, updateDate
        case userID = "userId"
        case writer
    }
}

struct PostInterviewIDSToRequest: Codable {
    let interviewID: Int

    enum CodingKeys: String, CodingKey {
        case interviewID = "interview_id"
    }
}

struct PostScriptIDToRequest: Codable {
    let scriptID: Int

    enum CodingKeys: String, CodingKey {
        case scriptID = "script_id"
    }
}

var postData: PostData?
