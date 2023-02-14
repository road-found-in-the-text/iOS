//
//  SignUpViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/01.
//

import UIKit

import Alamofire
import SwiftKeychainWrapper

class SignUpViewController: UIViewController {

    @IBOutlet weak var signupBtn: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkPasswordTextField: UITextField!
    
    @IBOutlet weak var isHiddenPasswordBtn: UIButton! //패스워드 보임 설정 버튼
    @IBOutlet weak var isHiddenCheckPasswordBtn: UIButton!//패스워드확인 보임 설정 버튼
    
    @IBOutlet weak var alertImgView: UIImageView!
    
    @IBOutlet weak var emailAddressLabel: UILabel!
    
    //비밀번호 성립 조건을 위한 정규식들 -> 길이, 숫자포함, 특수문자포함 순
    let regexForRange = "^(?=.*).{8,16}$"
    let regexForNumb = "^(?=.*[0-9]).{0,}$"
    let regexForMark = "^(?=.*[?!@#$%^&*()_+=-]).{0,}$"
    
    //비밀번호 조건 체크 이미지 -> 순서 상동
    @IBOutlet weak var checkImgRange: UIImageView!
    @IBOutlet weak var checkImgNum: UIImageView!
    @IBOutlet weak var checkImgMark: UIImageView!
    
    //비밀번호 조건 체크 라벨 -> 순서 상동
    @IBOutlet weak var checkLabelRange: UILabel!
    @IBOutlet weak var checkLabelNum: UILabel!
    @IBOutlet weak var checkLabelMark: UILabel!

    //두 비밀번호 일치 여부 이미지, 라벨
    
    @IBOutlet weak var isSamePasswordImg: UIImageView!
    @IBOutlet weak var isSamePasswordLabel: UILabel!
    
    //passwordTextField의 변화를 계속 지켜보고 있는 함수
    //실시간으로 정규식 검사를 해줌
    @objc func passwordTxtFieldDidChange(_ textField: UITextField) {
        
        //텍스트필드에 있는거를 String으로 변환
        let passwordForCheck : String = textField.text ?? " "
        
        //정규식 검사해주는 함수(Extension에 정의)
        checkRegexPassword(passwordForCheck)
        
        if ((passwordTextField.text == checkPasswordTextField.text) && emailTextField.text?.validateEmail() == true){
            isSamePasswordImg.image = UIImage(named: "checkmark_blue")
            isSamePasswordLabel.textColor = UIColor(hex: 0x007AFF)
            changeSignupBtnActive()
        }
        else{
            changeSignupBtnNonActive()
        }
        
    }
    
    //passwordTextField의 변화를 계속 지켜보고 있는 함수
    //passwordTextField 와 checkPasswordTextField 의 값이 일치하면 비밀번호 재설정 버튼이 파란색으로 변한다.
    @objc func checkPasswordTxtFieldDidChange(_ textField: UITextField){
        
        if ((passwordTextField.text == checkPasswordTextField.text) && emailTextField.text?.validateEmail() == true){
            isSamePasswordImg.image = UIImage(named: "checkmark_blue")
            isSamePasswordLabel.textColor = UIColor(hex: 0x007AFF)
            changeSignupBtnActive()
        }
        else{
            isSamePasswordImg.image = UIImage(named: "checkmark_gray")
            isSamePasswordLabel.textColor = UIColor(hex: 0xADB5BD)
            changeSignupBtnNonActive()
        }
    }
    
    @objc func emailTxtFieldDidChange(_ textField: UITextField){
        if ((passwordTextField.text == checkPasswordTextField.text) && emailTextField.text?.validateEmail() == true){
            changeSignupBtnActive()
        }
        else{
            changeSignupBtnNonActive()
        }
    }
    
    //다음 버튼 활성화시켜주는 함수
    func changeSignupBtnActive() {
        signupBtn.backgroundColor = UIColor(hex: 0x1E2022)
        signupBtn.setTitleColor(UIColor.white, for: .normal)
        signupBtn.isEnabled = true
    }
    
    //다음 버튼 비활성화시켜주는 함수
    func changeSignupBtnNonActive() {
        signupBtn.backgroundColor = UIColor(hex: 0xF0F5F9)
        signupBtn.setTitleColor(UIColor(hex: 0xADB5BD), for: .normal)
        signupBtn.isEnabled = false
    }
    
    //비밀번호 입력창 패스워드 보이게 하는 버튼 클릭 함수
    var isHiddenPassword : Bool = true //비밀번호 입력창 보임 유/무 불리언 변수
    @IBAction func didTapShowPasswordTxtField(_ sender: Any) {

        if isHiddenPassword{
            isHiddenPasswordBtn.setImage(UIImage(named: "ic_eye"), for: .normal)
            isHiddenPassword = false
            passwordTextField.isSecureTextEntry = false
            
        }
        else{
            isHiddenPasswordBtn.setImage(UIImage(named: "ic_eye off"), for: .normal)
            isHiddenPassword = true
            
            //만약 아무것도 입력을 안했는데 비밀번호 가리기를 눌렀을때 placeholder가 암호화가 되면 안되니까 존재하는 조건문
            if passwordTextField.text == "영문, 숫자, 특수문자 포함 8자~15자"{
                passwordTextField.isSecureTextEntry = false
            }
            else{
                passwordTextField.isSecureTextEntry = true
            }
        }
    
    }
    
    //비밀번호확인 입력창 패스워드 보이게 하는 버튼 클릭 함수
    var isHiddenCheckPassword : Bool = true //비밀번호확인 입력창 보임 유/무 불리언 변수
    @IBAction func didTapShowCheckPasswordTxtField(_ sender: Any) {
        if isHiddenCheckPassword{
            isHiddenCheckPasswordBtn.setImage(UIImage(named: "ic_eye"), for: .normal)
            isHiddenCheckPassword = false
            checkPasswordTextField.isSecureTextEntry = false
        }
        else{
            isHiddenCheckPasswordBtn.setImage(UIImage(named: "ic_eye off"), for: .normal)
            isHiddenCheckPassword = true
            
            //만약 아무것도 입력을 안했는데 비밀번호 가리기를 눌렀을때 placeholder가 암호화가 되면 안되니까 존재하는 조건문
            if checkPasswordTextField.text == "비밀번호 확인"{
                checkPasswordTextField.isSecureTextEntry = false
            }
            else{
                checkPasswordTextField.isSecureTextEntry = true
            }
        }
    }

    
    @IBAction func didTapSignUpBtn(_ sender: Any) {
        sendCertificationCodeToEmail()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        //네이게이션 타이틀 선언
        title = "회원가입"
        
        //Back 버튼 텍스트 없애기
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        signupBtn.layer.cornerRadius = 8
        
        //Texr Field 초기설정
        passwordTextField.delegate = self
        passwordTextField.text = "영문, 숫자, 특수문자 포함 8자~15자"
        passwordTextField.textColor = UIColor(hex: 0xADB5BD)
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        passwordTextField.layer.cornerRadius = 6
        
        checkPasswordTextField.delegate = self
        checkPasswordTextField.text = "비밀번호 확인"
        checkPasswordTextField.textColor = UIColor(hex: 0xADB5BD)
        checkPasswordTextField.layer.borderWidth = 1
        checkPasswordTextField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        checkPasswordTextField.layer.cornerRadius = 6
        
        emailTextField.delegate = self
        emailTextField.text = "abc@email.com"
        emailTextField.textColor = UIColor(hex: 0xADB5BD)
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        emailTextField.layer.cornerRadius = 6
        
        //위에서 만든 TextField 감시 함수를 각 TextField에 add해주는 코드
        passwordTextField.addTarget(self, action: #selector(SignUpViewController.passwordTxtFieldDidChange(_:)), for: .editingChanged)
        
        checkPasswordTextField.addTarget(self, action: #selector(SignUpViewController.checkPasswordTxtFieldDidChange(_:)), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(SignUpViewController.emailTxtFieldDidChange(_:)), for: .editingChanged)
        
        changeSignupBtnNonActive()
        signupBtn.setBackgroundColor(UIColor(hex: 0xF0F5F9), for: .highlighted)
        signupBtn.setTitleColor(UIColor(hex: 0xADB5BD), for: .highlighted)
        
        // 텍스트필드 왼쪽 여백 주기
        emailTextField.setLeftPaddingPoints(16)
        passwordTextField.setLeftPaddingPoints(16)
        checkPasswordTextField.setLeftPaddingPoints(16)
        
        //화면 어딘가를 눌렀을때 키보드 내리기
        dismissKeyboardWhenTappedAround()
        
        alertImgView.isHidden = true
    }
    
}

extension SignUpViewController{
    //비밀번호 정규식 검사해주는 함수
    //조건에 맞으면 Img와 Label을 파란색으로 만들고 아니면 회색으로 바꿔준다.
    func checkRegexPassword(_ password: String){
        
        if (password.range(of: regexForRange, options: .regularExpression) != nil) == true{
            checkImgRange.image = UIImage(named: "checkmark_blue")
            checkLabelRange.textColor = UIColor(hex: 0x007AFF)
        }
        else{
            checkImgRange.image = UIImage(named: "checkmark_gray")
            checkLabelRange.textColor = UIColor(hex: 0xADB5BD)
        }
        
        if (password.range(of: regexForNumb, options: .regularExpression) != nil) == true{
            checkImgNum.image = UIImage(named: "checkmark_blue")
            checkLabelNum.textColor = UIColor(hex: 0x007AFF)
        }
        else{
            checkImgNum.image = UIImage(named: "checkmark_gray")
            checkLabelNum.textColor = UIColor(hex: 0xADB5BD)
        }
        
        if (password.range(of: regexForMark, options: .regularExpression) != nil) == true{
            checkImgMark.image = UIImage(named: "checkmark_blue")
            checkLabelMark.textColor = UIColor(hex: 0x007AFF)
        }
        else{
            checkImgMark.image = UIImage(named: "checkmark_gray")
            checkLabelMark.textColor = UIColor(hex: 0xADB5BD)
        }
        
    }
    
    func changeConditionNonActive(){
        checkImgMark.image = UIImage(named: "checkmark_gray")
        checkLabelMark.textColor = UIColor(hex: 0xADB5BD)
        
        checkImgNum.image = UIImage(named: "checkmark_gray")
        checkLabelNum.textColor = UIColor(hex: 0xADB5BD)
        
        checkImgRange.image = UIImage(named: "checkmark_gray")
        checkLabelRange.textColor = UIColor(hex: 0xADB5BD)
    }
}

extension SignUpViewController: UITextFieldDelegate{
    
    //textField 눌렀을 때 테두리색 검은색되도록
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //현재 texField text color가 placeholder색이면 눌렀을 때 텍스트 내용 비우고, 테두리 검은색으로
        
        changeSignupBtnNonActive()
        if textField == passwordTextField{
            changeConditionNonActive()
            changeSignupBtnNonActive()
            isSamePasswordImg.image = UIImage(named: "checkmark_gray")
            isSamePasswordLabel.textColor = UIColor(hex: 0xADB5BD)
            textField.text = ""
            textField.layer.borderColor = UIColor(hex: 0x52616A).cgColor
            if textField.textColor == UIColor(hex: 0xADB5BD) {
                textField.text = nil
                textField.textColor = UIColor.black
                
                if isHiddenPassword == false{
                    textField.isSecureTextEntry = false
                }
                else{
                    textField.isSecureTextEntry = true
                }
            }
        }
        else if textField == checkPasswordTextField{
            textField.text = ""
            isSamePasswordImg.image = UIImage(named: "checkmark_gray")
            isSamePasswordLabel.textColor = UIColor(hex: 0xADB5BD)
            textField.layer.borderColor = UIColor(hex: 0x52616A).cgColor
            if textField.textColor == UIColor(hex: 0xADB5BD) {
                textField.text = nil
                textField.textColor = UIColor.black
                
                if isHiddenCheckPassword == false{
                    textField.isSecureTextEntry = false
                }
                else{
                    textField.isSecureTextEntry = true
                }
            }
        }
        else{
            
            textField.text = ""
            textField.textColor = UIColor(hex: 0xADB5BD)
            if textField.textColor == UIColor(hex: 0xADB5BD) {
                textField.text = nil
                textField.textColor = UIColor.black
                
            }
            
            if textField.layer.borderColor != UIColor(hex: 0xFF3B30).cgColor{
                textField.layer.borderColor = UIColor(hex: 0x52616A).cgColor
            }
        }
        
    }
    
    //Edit이 끝났을때 비어있으면 다시 placeholder 써놓고, 테두리 색상 바꿔줌
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField{
            if ((textField.text?.isEmpty) == true) {
                textField.isSecureTextEntry = false
                textField.text = "영문, 숫자, 특수문자 포함 8자~15자"
                textField.textColor = UIColor(hex: 0xD3D7DC)
          }
            passwordTextField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        }
        else if textField == checkPasswordTextField{
            if ((textField.text?.isEmpty) == true) {
                textField.isSecureTextEntry = false
                textField.text = "비밀번호 확인"
                textField.textColor = UIColor(hex: 0xD3D7DC)
          }
            checkPasswordTextField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        }
        else{
            if ((textField.text?.isEmpty) == true) {
                textField.isSecureTextEntry = false
                textField.text = "abc@email.com"
                textField.textColor = UIColor(hex: 0xD3D7DC)
          }
            
            if textField.layer.borderColor != UIColor(hex: 0xFF3B30).cgColor{
                textField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
            }
            
        }

    }
    
    //return 버튼 눌렀을 때 이벤트 생성
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.passwordTextField {
            self.checkPasswordTextField.becomeFirstResponder()
        }
        else{
            if signupBtn.isEnabled == true{
                signupBtn.sendActions(for: .touchUpInside)
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


extension SignUpViewController{
    
    func sendCertificationCodeToEmail(){
        let url = "\(Constant.BASE_URL)/members/signup"

        let email = emailTextField.text ?? ""
        
        let pw = checkPasswordTextField.text ?? ""

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
                        
                        let storyboard = UIStoryboard(name: "SetNickName", bundle: nil)
                        
                        guard let vc = storyboard.instantiateViewController(withIdentifier: "SetNickNameViewController") as? SetNickNameViewController else { return }
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }
                    else{
                        self.emailAddressLabel.textColor = UIColor(hex: 0xFF3B30)
                        self.emailAddressLabel.text = "이미 가입된 이메일입니다."
                        
                        self.emailTextField.layer.borderColor = UIColor(hex: 0xFF3B30).cgColor
                    }
                    
                

                case .failure(let error):
                    print("DEBUG>> signUpNormalPriv Error : \(error.localizedDescription)")

                }
                }
            }
}
