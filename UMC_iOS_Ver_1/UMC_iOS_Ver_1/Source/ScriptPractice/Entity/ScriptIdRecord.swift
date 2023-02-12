//
//  ScriptIdRecord.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/12.
//

import Foundation

struct ScriptIdRecord: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let data: ScriptIdRecordData
}

struct ScriptIdRecordData: Codable {
    let resultCount: Int
    let mean: Double
    let totalElapsedMinute: Int
    let totalElapsedSecond: Int
    let records: [ScriptRecordData]
    let memoList: [ScriptRecordMemoData]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "result_count"
        case mean
        case totalElapsedMinute = "total_elapsed_minute"
        case totalElapsedSecond = "total_elapsed_second"
        case records
        case memoList
    }
}
