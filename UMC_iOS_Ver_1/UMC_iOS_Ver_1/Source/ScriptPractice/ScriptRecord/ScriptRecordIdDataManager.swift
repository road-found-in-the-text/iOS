//
//  ScriptRecordIdDataManager.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/12.
//

import Foundation
import Alamofire

protocol ScriptRecordIdDelegate {
    func didFetchScriptRecordById(result: ScriptIdRecordData)
}

class ScriptRecordIdDataManager {
    func fetchScriptRecordById(scriptId: Int, delegate: ScriptRecordIdDelegate) {
        let url = "\(Constant.BASE_URL)/record/script/\(scriptId)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: ScriptIdRecord.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchScriptRecordById(result: response.data)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
}
