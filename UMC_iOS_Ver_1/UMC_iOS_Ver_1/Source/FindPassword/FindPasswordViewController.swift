//
//  FindPasswordViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/02.
//

import UIKit

import Alamofire
import SwiftKeychainWrapper

class FindPasswordViewController: UIViewController {

    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    @IBOutlet weak var certificationLabel: UILabel!
    
    @IBOutlet weak var certificationTxtField: UITextField!
    
    
    //발송버튼 눌렀을때 액션 함수
    @IBAction func didTapSendBtn(_ sender: Any) {
        appearComponent()
        startCountdown()
    }
    
    var countdown = 600
       
    func startCountdown() {
        DispatchQueue.main.async {
            guard self.countdown > 0 else { return }
            self.countdown -= 1
            let minutes = self.countdown / 60
            let seconds = self.countdown % 60
            self.countdownLabel.text = String(format: "%02d:%02d", minutes, seconds)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startCountdown()
            }
        }
    }
    
    //email이 정규식을 만족시키는지 감시해주는 함수
    @objc func emailTxtFieldDidChange(_ textField: UITextField) {
        if emailTxtField.text?.validateEmail() == true{
            changeNextBtnActive()
        }
        else{
            changeNextBtnNonActive()
        }
        
    }
    
    //다음 버튼 활성화시켜주는 함수
    func changeNextBtnActive() {
        sendBtn.backgroundColor = UIColor.black
        sendBtn.setTitleColor(UIColor.white, for: .normal)
        sendBtn.layer.cornerRadius = 8
        sendBtn.isEnabled = true
    }
    
    //다음 버튼 비활성화시켜주는 함수
    func changeNextBtnNonActive() {
        sendBtn.backgroundColor = UIColor(hex: 0xF0F5F9)
        sendBtn.setTitleColor(UIColor(hex: 0xADB5BD), for: .normal)
        sendBtn.layer.cornerRadius = 6
        sendBtn.isEnabled = false
    }
    
    //
    func hideComponent(){
        certificationLabel.isHidden = true
        certificationTxtField.isHidden = true
        countdownLabel.isHidden = true
        confirmBtn.isHidden = true
    }
    
    func appearComponent(){
        certificationLabel.isHidden = false
        certificationTxtField.isHidden = false
        countdownLabel.isHidden = false
        confirmBtn.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        sendBtn.isEnabled = false
        
        confirmBtn.layer.cornerRadius = 8
        
        //위에서 만든 email 텍스트필드 감시함수 add
        emailTxtField.addTarget(self, action: #selector(FindPasswordViewController.emailTxtFieldDidChange(_:)), for: .editingChanged)
    
        hideComponent()
    }
    

}


extension FindPasswordViewController{
    //동의하고 시작하기 -> 최종 회원가입 버튼(애플)
//    func sendCertificationCodeToEmail(){
//        let url = "\(Constant.BASE_URL)/auth/sign-up"
//       
//        let email = KeychainWrapper.standard.string(forKey: "appleEmail")
//        
//        let username = KeychainWrapper.standard.string(forKey: "userAppleID")
//        
//        let signupPurpose = UserDefaults.standard.integer(forKey: "signupPurpose")
//        
//        let marketing = UserDefaults.standard.string(forKey: "marketing")
//        
//        let agreementCheck = UserDefaults.standard.string(forKey: "agreementCheck")
//        
//        
//        let bodyData : Parameters = [
//            "email" : email ?? " ",
//            "username" : username ?? " ",
//            "signupPurpose" : signupPurpose,
//            "referralCode" : " ",
//            "marketing" : marketing ?? "",
//            "agreementCheck" : agreementCheck ?? "",
//            "isApple" : true
//            
//        ]
//        
//        print(bodyData)
//        
//        AF.request(url,
//                   method: .post,
//                   parameters: bodyData,
//                   encoding: JSONEncoding.default,
//                   headers: nil).responseDecodable(of: SignupAppleCompleteResponse.self){
//                response in
//                
//                switch response.result {
//                    
//                case .success(let response):
//                    print("SUCCESS>> signUpNormalPriv Response \(response) ")
//                    
//                    //키체인에 UserID 저장
//                    KeychainWrapper.standard.set(response.id ?? 0, forKey: "UserID")
//                    
//                    //키체인에 RefreshToken 저장
//                    KeychainWrapper.standard.set(response.refreshToken ?? "" , forKey: "RefreshToken")
//                    
//                    //키체인에 AccessToken 저장
//                    KeychainWrapper.standard.set(response.accessToken ?? "" , forKey: "AccessToken")
//                    
//                    //혹시 같은 기기내에서 아이디 두번 만들수도 있으니 isAutoLogin값 false로 바꿔줌
//                    UserDefaults.standard.set(false, forKey: "isAutoLogin")
//                    
//                    //회원가입 완료 페이지로 이동
//                    let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
//                    
//                    guard let vc = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else{ return }
//                    
//                    vc.modalPresentationStyle = .fullScreen
//                    
//                    self.present(vc, animated: true)
//                    
//                    
//                case .failure(let error):
//                    print("DEBUG>> signUpNormalPriv Error : \(error.localizedDescription)")
//                                    
//                }
//                }
//            }
}
