//
//  MyPageDataManager.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/14.
//

import Foundation
import Alamofire

protocol MyPageDelegate {
    func didFetchMemberData(member: MemberData)
}

protocol MyPageStorageDelegate {
    func didFetchMemberScriptData(memberScript: MemberScript)
}

class MyPageDataManager {
    func fetchMemberData(id: Int, delegate: MyPageDelegate) {
        let url = "\(Constant.BASE_URL)/members/\(id)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: Member.self) { response in
                switch response.result {
                case .success(let resposne):
                    delegate.didFetchMemberData(member: resposne.data)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
    
    func fetchMemberScriptData(id: Int, delegate: MyPageStorageDelegate) {
        let url = "\(Constant.BASE_URL)/script/member/\(id)"
        
        AF.request(url, method: .get)
            .validate()
            .responseDecodable(of: MemberScript.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didFetchMemberScriptData(memberScript: response)
                case .failure(let error):
                    print(String(describing: error))
                }
            }
    }
}
