//
//  ScriptRecordDataManager.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/12.
//

import Foundation
import Alamofire

protocol ScriptRecordPostDelegate {
    func didPostScriptRecord(result: ScriptRecordData)
}

class ScriptRecordDataManager {
    func postScriptRecord(scriptId: Int, parameters: Parameters, delegate: ScriptRecordPostDelegate ) {
        let url = "\(Constant.BASE_URL)/record/script/\(scriptId)/new"
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: ScriptRecordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didPostScriptRecord(result: response.data)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
    
    func setPostScriptParameters(elapsedTime: Int, answer: [PracticeAnswer]) -> Parameters {
        var parameters: Parameters = [:]
        
        for i in 0..<5 {
            guard let firstAnswer = answer[i].firstAnswer, let secondAnswer = answer[i].secondAnswer else {
                assert(false)
            }
            parameters["score\(i+1)"] = Double(firstAnswer + secondAnswer) / 2.0
        }
        
        parameters["elapsed_minute"] = elapsedTime / 60
        parameters["elapsed_second"] = elapsedTime % 60
        
        return parameters
    }
}
