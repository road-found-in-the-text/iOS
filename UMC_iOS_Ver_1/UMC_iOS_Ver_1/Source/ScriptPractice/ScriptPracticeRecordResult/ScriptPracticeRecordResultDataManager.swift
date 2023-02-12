//
//  ScriptPracticeRecordResultDataManager.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/12.
//

import Foundation
import Alamofire

protocol ScriptRecordMemoDelegate {
    func didPostScriptRecordMemo()
}

class ScriptPracticeRecordResultDataManager {
    func postScriptRecordMemo(scriptId: Int, memo: String, delegate: ScriptRecordMemoDelegate) {
        let url = "\(Constant.BASE_URL)/record/script/\(scriptId)/memo/new"
        let parameters: Parameters = ["memo": memo]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: ScriptRecordMemoResponse.self) { response in
                switch response.result {
                case .success(_):
                    delegate.didPostScriptRecordMemo()
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
}
