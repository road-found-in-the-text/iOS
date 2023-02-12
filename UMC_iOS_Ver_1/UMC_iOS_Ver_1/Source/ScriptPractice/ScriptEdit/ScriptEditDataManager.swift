//
//  ScriptEditDataManager.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import Alamofire

protocol ScriptEditDelegate {
    func didFetchScriptById(result: Script)
}

class ScriptEditDataManager {
    func fetchScriptById(id: Int, delegate: ScriptEditDelegate) {
        let url = "\(Constant.BASE_URL)/script/\(id)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Script.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchScriptById(result: response)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
}
