//
//  ScriptRecordMemoResponse.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/12.
//

import Foundation

struct ScriptRecordMemoResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: ScriptRecordMemoData
}

struct ScriptRecordMemoData: Codable {
    let resultCount: Int
    let memo: String
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "result_count"
        case memo
    }
}
