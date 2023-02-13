//
//  BestForumDataModel.swift
//  project
//
//  Created by 왕정빈 on 2023/01/06.
//

import Foundation

struct BestForumDataModel: Codable {
    let code: Int
    let data: [BestForumData]
    let isSuccess: Bool
    let message: String
}

struct BestForumData: Codable {
    let comment: String
    let commentNum: Int
    let createDate: String
    let forumID: Int
    let forumImageURL: [String]?
    let imageVideoNum: Int
    let bestForuminterviewIDSToRequests: [BestForumInterviewIDSToRequest]
    let interviewNum, likeNum: Int
    let bestForumscriptIDToRequests: [BestForumScriptIDToRequest]
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
        case bestForuminterviewIDSToRequests = "interviewIdsToRequests"
        case interviewNum = "interview_num"
        case likeNum = "like_num"
        case bestForumscriptIDToRequests = "scriptIdToRequests"
        case scriptNum = "script_num"
        case title, updateDate
        case userID = "userId"
        case writer
    }
}

struct BestForumInterviewIDSToRequest: Codable {
    let interviewID: Int

    enum CodingKeys: String, CodingKey {
        case interviewID = "interview_id"
    }
}

struct BestForumScriptIDToRequest: Codable {
    let scriptID: Int

    enum CodingKeys: String, CodingKey {
        case scriptID = "script_id"
    }
}

var bestForumData: [BestForumData] = []
