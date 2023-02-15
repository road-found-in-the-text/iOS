//
//  Script.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import Foundation

struct Script: Codable {
    let result: String
    let memberId: Int?
    let scriptId: Int
    let title: String
    let contents: String
    let paragraphList: [ScriptParagraph]
    let createdDate: String
    let modifiedDate: String
}

struct ScriptParagraph: Codable {
    let createdDate: String
    let modifiedDate: String
    let paragraphId: Int
    let scriptId: ScriptId
    let title: String
    let contents: String
    let deleted: Bool
}

struct ScriptId: Codable {
    let createdDate: String
    let modifiedDate: String
    let scriptId: Int
    let title: String
    let resultCount: Int
    let totalElapsedMinute: Int
    let totalElapsedSecond: Int
    let deleted: Bool
    
    enum CodingKeys: String, CodingKey {
        case createdDate
        case modifiedDate
        case scriptId
        case title
        case resultCount = "result_count"
        case totalElapsedMinute = "total_elapsed_minute"
        case totalElapsedSecond = "total_elapsed_second"
        case deleted
    }
}
