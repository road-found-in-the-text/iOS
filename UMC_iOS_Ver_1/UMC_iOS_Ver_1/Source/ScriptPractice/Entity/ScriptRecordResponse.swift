//
//  ScriptRecordResponse.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/12.
//

import Foundation

struct ScriptRecordResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: ScriptRecordData
}

struct ScriptRecordData: Codable {
    let resultCount: Int
    let mean: Double?
    let score1: Double
    let score2: Double
    let score3: Double
    let score4: Double
    let score5: Double
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "result_count"
        case mean
        case score1
        case score2
        case score3
        case score4
        case score5
    }
}
