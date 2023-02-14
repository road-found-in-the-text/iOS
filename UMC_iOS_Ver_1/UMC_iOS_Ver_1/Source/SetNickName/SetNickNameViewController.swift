//
//  SetNickNameViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/13.
//

import UIKit

import Alamofire
import SwiftKeychainWrapper

class SetNickNameViewController: UIViewController {

    @IBOutlet weak var nickNameTxtField: UITextField!
    
    @IBOutlet weak var alertImgView: UIImageView!
    
    @IBOutlet weak var checkBtnAll: UIButton!
    
    @IBOutlet weak var checkBtn1: UIButton!
    @IBOutlet weak var checkBtn2: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var flagBtnAll = false
    var flagBtn1 = false
    var flagBtn2 = false

    @IBAction func didTapNextBtn(_ sender: Any) {
        
    }
    
    @IBAction func didTapCheckBtnAll(_ sender: Any) {
        //flag가 false일때 -> 체크 안되어있을때 눌러서 체크해라!
        if flagBtnAll == false {
            checkBtnAll.setImage(UIImage(named: "ic_check square"), for: .normal)
            checkBtn1.setImage(UIImage(named: "ic_check square"), for: .normal)
            checkBtn2.setImage(UIImage(named: "ic_check square"), for: .normal)
            flagBtnAll = true
            flagBtn1 = true
            flagBtn2 = true
        }
        else{//flag가 true일때 -> 체크 되어있을때 눌러서 체크해제!
            checkBtnAll.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
            checkBtn1.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
            checkBtn2.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
            flagBtnAll = false
            flagBtn1 = false
            flagBtn2 = false
        }
    }
    
    @IBAction func didTapCheckBtn1(_ sender: Any) {
        //flag가 false일때 -> 체크 안되어있을때 눌러서 체크해라!
        if flagBtn1 == false {
            //Btn2가 체크되어 있을경우 BtnAll까지 체크 ㄱㄱ
            if flagBtn2 == true {
                checkBtn1.setImage(UIImage(named: "ic_check square"), for: .normal)
                checkBtnAll.setImage(UIImage(named: "ic_check square"), for: .normal)
                
                flagBtn1 = true
                flagBtnAll = true
            }
            //Btn2가 체크 안되어있어서 그냥 Btn1만 체크하면됨
            else{
                checkBtn1.setImage(UIImage(named: "ic_check square"), for: .normal)
                flagBtn1 = false
            }
        }
        //flag가 true일때 -> 체크 되어있을때 눌러서 체크해제해라!
        else{
            //Btn2도 체크되어 있어서, BtnAll까지 체크해제
            if flagBtn2 == true {
                checkBtn1.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
                checkBtnAll.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
                
                flagBtn1 = true
                flagBtnAll = true
            }
            else{//Btn2이 체크안되어 있어서, Btn1만 체크해제
                checkBtn1.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
                flagBtn1 = false
            }
        }
    }
    
    
    @IBAction func didTapCheckBtn2(_ sender: Any) {
        //flag가 false일때 -> 체크 안되어있을때 눌러서 체크해라!
        if flagBtn2 == false {
            //Btn1가 체크되어 있을경우 BtnAll까지 체크 ㄱㄱ
            if flagBtn1 == true {
                checkBtn2.setImage(UIImage(named: "ic_check square"), for: .normal)
                checkBtnAll.setImage(UIImage(named: "ic_check square"), for: .normal)
                
                flagBtn2 = true
                flagBtnAll = true
            }
            //Btn1가 체크 안되어있어서 그냥 Btn1만 체크하면됨
            else{
                checkBtn2.setImage(UIImage(named: "ic_check square"), for: .normal)
                flagBtn2 = false
            }
        }
        //flag가 true일때 -> 체크 되어있을때 눌러서 체크해제해라!
        else{
            //Btn1도 체크되어 있어서, BtnAll까지 체크해제
            if flagBtn1 == true {
                checkBtn2.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
                checkBtnAll.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
                
                flagBtn2 = true
                flagBtnAll = true
            }
            else{//Btn1이 체크안되어 있어서, Btn2만 체크해제
                checkBtn2.setImage(UIImage(named: "ic_CheckBox_UnSelected"), for: .normal)
                flagBtn2 = false
            }
        }
    }
    
    
    @IBAction func didTapSubsBtn1(_ sender: Any) {
        
    }
    
    
    @IBAction func didTapSubsBtn2(_ sender: Any) {
        
    }
    
    
    //다음 버튼 활성화시켜주는 함수
    func changeNextBtnActive() {
        nextBtn.backgroundColor = UIColor(hex: 0x1E2022)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.isEnabled = true
    }
    
    //다음 버튼 비활성화시켜주는 함수
    func changeNextBtnNonActive() {
        nextBtn.backgroundColor = UIColor(hex: 0xF0F5F9)
        nextBtn.setTitleColor(UIColor(hex: 0xADB5BD), for: .normal)
        nextBtn.isEnabled = false
    }
    
    //passwordTextField의 변화를 계속 지켜보고 있는 함수
    @objc func nicknameTextFieldDidChange(_ textField: UITextField){
        
        if (textField.text?.count ?? 0 > 0) {
            
            changeNextBtnActive()
        }
        else{
            changeNextBtnNonActive()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //네이게이션 타이틀 선언
        title = "닉네임 설정"
        
        //Back 버튼 텍스트 없애기
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        nextBtn.layer.cornerRadius = 8
        
        //Texr Field 초기설정
        nickNameTxtField.delegate = self
        nickNameTxtField.text = "글길"
        nickNameTxtField.textColor = UIColor(hex: 0xADB5BD)
        nickNameTxtField.layer.borderWidth = 1
        nickNameTxtField.layer.borderColor = UIColor(hex: 0xEFF1F3).cgColor
        nickNameTxtField.layer.cornerRadius = 6
        
        alertImgView.isHidden = true
        
        //위에서 만든 TextField 감시 함수를 각 TextField에 add해주는 코드
        nickNameTxtField.addTarget(self, action: #selector(SetNickNameViewController.nicknameTextFieldDidChange(_:)), for: .editingChanged)
        
        changeNextBtnNonActive()
        
        // 텍스트필드 왼쪽 여백 주기
        nickNameTxtField.setLeftPaddingPoints(16)
        
    }
    

}

extension SetNickNameViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField){
        
    }
    
    //Edit이 끝났을때 비어있으면 다시 placeholder 써놓고, 테두리 색상 바꿔줌
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }
    
    //공백 입력 방지
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
}

extension SetNickNameViewController{
    
    func setNickName(){
        let url = "\(Constant.BASE_URL)/members/\(Constant.MemberID)"

        let nickName = nickNameTxtField.text ?? ""
        
        let bodyData : Parameters = [
            
            "nickName": nickName,
            "merberId": Constant.MemberID
        ]

        let header : HTTPHeaders = [
            
            "Authorization" : KeychainWrapper.standard.string(forKey: "JWT") ?? ""
        
        ]
        
        print(bodyData)

        AF.request(url,
                   method: .patch,
                   parameters: bodyData,
                   encoding: JSONEncoding.default,
                   headers: header).responseDecodable(of: SetNickNameResponse.self){
                response in

                switch response.result {

                case .success(let response):
                    print("SUCCESS>> signUpNormalPriv Response \(response) ")
                    
                    if response.code == 1000 {
                       

                        //혹시 같은 기기내에서 아이디 두번 만들수도 있으니 isAutoLogin값 false로 바꿔줌
                        UserDefaults.standard.set(false, forKey: "isAutoLogin")
                        
                        let storyboard = UIStoryboard(name: "SetNickName", bundle: nil)
                        
                        guard let vc = storyboard.instantiateViewController(withIdentifier: "SetNickNameViewController") as? SetNickNameViewController else { return }
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                    }
                    else{
//                        self.emailAddressLabel.textColor = UIColor(hex: 0xFF3B30)
//                        self.emailAddressLabel.text = "이미 가입된 이메일입니다."
//                        self.emailTextField.layer.borderColor = UIColor(hex: 0xFF3B30).cgColor
                    }
                    
                

                case .failure(let error):
                    print("DEBUG>> signUpNormalPriv Error : \(error.localizedDescription)")

                }
                }
            }
}
