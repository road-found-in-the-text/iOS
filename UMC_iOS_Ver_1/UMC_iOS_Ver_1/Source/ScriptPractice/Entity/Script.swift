//
//  Script.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/09.
//

import Foundation

struct Script: Codable {
    let createdDate: String
    let modifiedDate: String
    let scriptId: Int
    let title: String
    let deleted: Bool
    let memo: Memo
}

struct Memo: Codable {
    let id: Int
    let memo: String
    let script: Script
}
