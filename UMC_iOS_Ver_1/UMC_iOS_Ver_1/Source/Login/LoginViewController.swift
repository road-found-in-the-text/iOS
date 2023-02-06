//
//  LoginViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/02/01.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var kakaoLoginBtn: UIButton!
    
    @IBOutlet weak var appleLoginBtn: UIButton!
    
    @IBAction func didTapSignupWithEmail(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "SignUpPage", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kakaoLoginBtn.layer.cornerRadius = 8
        appleLoginBtn.layer.cornerRadius = 8
    }
    

}

