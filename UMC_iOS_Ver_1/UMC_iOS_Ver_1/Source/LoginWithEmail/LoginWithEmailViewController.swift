//
//  LoginWithEmailViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/10.
//

import UIKit

import Alamofire
import SwiftKeychainWrapper

class LoginWithEmailViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    
    
    //emailTxtField의 변화를 계속 지켜보고 있는 함수
    @objc func emailTxtFieldDidChange(_ textField: UITextField) {
        
        if (emailTxtField.text?.validateEmail() == true && passwordTxtField.text != "8자 이상의 비밀번호" && passwordTxtField.text?.count ?? 0 > 7) {
            
            changeLoginBtnActive()
        }
        else{
            changeLoginBtnNonActive()
        }
        
    }
    
    //passwordTextField의 변화를 계속 지켜보고 있는 함수
    @objc func passwordTxtFieldDidChange(_ textField: UITextField){
        
        if (emailTxtField.text?.validateEmail() == true && passwordTxtField.text != "8자 이상의 비밀번호" && passwordTxtField.text?.count ?? 0 > 7) {
            
            changeLoginBtnActive()
        }
        else{
            changeLoginBtnNonActive()
        }
    }
    
    
    //로그인 버튼 활성화시켜주는 함수
    func changeLoginBtnActive() {
        loginBtn.backgroundColor = UIColor(hex: 0x1E2022)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.isEnabled = true
    }
    
    //로그인 버튼 비활성화시켜주는 함수
    func changeLoginBtnNonActive() {
        loginBtn.backgroundColor = UIColor(hex: 0xF0F5F9)
        loginBtn.setTitleColor(UIColor(hex: 0xADB5BD), for: .normal)
        loginBtn.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //네이게이션 타이틀 선언
        title = "로그인"
        
        //Back 버튼 텍스트 없애기
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        loginBtn.layer.cornerRadius = 8
        
        //Texr Field 초기설정
        emailTxtField.delegate = self
        emailTxtField.text = "abc@email.com"
        emailTxtField.textColor = UIColor(hex: 0xADB5BD)
        emailTxtField.layer.borderWidth = 1
        emailTxtField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        emailTxtField.layer.cornerRadius = 6
        
        passwordTxtField.delegate = self
        passwordTxtField.text = "8자 이상의 비밀번호"
        passwordTxtField.textColor = UIColor(hex: 0xADB5BD)
        passwordTxtField.layer.borderWidth = 1
        passwordTxtField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        passwordTxtField.layer.cornerRadius = 6
        
        //위에서 만든 TextField 감시 함수를 각 TextField에 add해주는 코드
        emailTxtField.addTarget(self, action: #selector(LoginWithEmailViewController.emailTxtFieldDidChange(_:)), for: .editingChanged)
        
        passwordTxtField.addTarget(self, action: #selector(LoginWithEmailViewController.passwordTxtFieldDidChange(_:)), for: .editingChanged)
        
        changeLoginBtnNonActive()
        loginBtn.setBackgroundColor(UIColor(hex: 0xF0F5F9), for: .highlighted)
        loginBtn.setTitleColor(UIColor(hex: 0xADB5BD), for: .highlighted)
        
        // 텍스트필드 왼쪽 여백 주기
        emailTxtField.setLeftPaddingPoints(16)
        passwordTxtField.setLeftPaddingPoints(16)
    }
    
}

extension LoginWithEmailViewController: UITextFieldDelegate{
    
    //textField 눌렀을 때 테두리색 검은색되도록
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //현재 texField text color가 placeholder색이면 눌렀을 때 텍스트 내용 비우고, 테두리 검은색으로
        
        changeLoginBtnNonActive()
        
        if textField == emailTxtField {
            textField.text = ""
            if textField.textColor == UIColor(hex: 0xADB5BD) {
                textField.text = nil
                textField.textColor = UIColor.black
                
            }
            
            if textField.layer.borderColor != UIColor(hex: 0xFF3B30).cgColor{
                textField.layer.borderColor = UIColor(hex: 0x52616A).cgColor
            }
        }
        else{
            
            textField.text = ""
            textField.isSecureTextEntry = true
            textField.layer.borderColor = UIColor(hex: 0x52616A).cgColor
            if textField.textColor == UIColor(hex: 0xADB5BD) {
                textField.text = nil
                textField.textColor = UIColor.black
            }
        }
        
    }
    
    //Edit이 끝났을때 비어있으면 다시 placeholder 써놓고, 테두리 색상 바꿔줌
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTxtField{
            if ((textField.text?.isEmpty) == true) {
                textField.text = "abc@emil.com"
                textField.textColor = UIColor(hex: 0xADB5BD)
          }
            
            if textField.layer.borderColor != UIColor(hex: 0xFF3B30).cgColor{
                textField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
            }
            
        }
        else{
            if ((textField.text?.isEmpty) == true) {
                textField.isSecureTextEntry = false
                textField.text = "8자 이상의 비밀번호"
                textField.textColor = UIColor(hex: 0xADB5BD)
          }
            textField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
            
        }

    }
    
    //return 버튼 눌렀을 때 이벤트 생성
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailTxtField {
            self.passwordTxtField.becomeFirstResponder()
        }
        else{
            if loginBtn.isEnabled == true{
                loginBtn.sendActions(for: .touchUpInside)
            }
            
        }
            return true
    }
    
    //공백 입력 방지
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

extension LoginWithEmailViewController{
    
    func postNormalLogin(){
        let url = "\(Constant.BASE_URL)/members/login"

        let email = emailTxtField.text ?? ""
        
        let pw = passwordTxtField.text ?? ""

        let bodyData : Parameters = [
            "email": email,
            "pw": pw
        ]

        print(bodyData)

        AF.request(url,
                   method: .post,
                   parameters: bodyData,
                   encoding: JSONEncoding.default,
                   headers: nil).responseDecodable(of: NormalSignupResponse.self){
                response in

                switch response.result {

                case .success(let response):
                    print("SUCCESS>> signUpNormalPriv Response \(response) ")
                    
                    if response.code == 1000 {
                        //키체인에 UserID 저장
                        KeychainWrapper.standard.set(response.data?.memberID ?? 0, forKey: "MemberID")

                        //키체인에 JWT 저장
                        KeychainWrapper.standard.set(response.data?.jwt ?? "" , forKey: "JWT")

                        //혹시 같은 기기내에서 아이디 두번 만들수도 있으니 isAutoLogin값 false로 바꿔줌
                        UserDefaults.standard.set(false, forKey: "isAutoLogin")
                        UserDefaults.standard.set(true, forKey: "loginUser")
                    }
                    else{
                        
                        self.emailAddressLabel.textColor = UIColor(hex: 0xFF3B30)
                        self.emailAddressLabel.text = "이미 가입된 이메일입니다."
                        
                        self.emailTxtField.layer.borderColor = UIColor(hex: 0xFF3B30).cgColor
                    }
                    
                

                case .failure(let error):
                    print("DEBUG>> signUpNormalPriv Error : \(error.localizedDescription)")

                }
                }
            }
}
