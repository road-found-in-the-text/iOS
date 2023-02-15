//
//  ProfileEditViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

import Kingfisher

class ProfileEditViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileEditButton: UIButton!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var bioView: UIView!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var bioTextCoundLabel: UILabel!
    
    var userInfo: MemberData?

    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange), for: .editingChanged)
        bioTextView.delegate = self
        self.dismissKeyboardWhenTappedAround()
        
        configureNavigationBar()
        style()
    }
    
    @objc func nicknameTextFieldDidChange() {
        setDoneButtonStatus()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "프로필 수정"
        
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneButtonTapped))
        doneButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        doneButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .disabled)
        doneButton.isEnabled = false
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func doneButtonTapped() {
        print("완료")
    }
    
    func setDoneButtonStatus() {
        let isEnabled = (nicknameTextField.text?.isExists ?? false) && bioTextView.text.isExists
        navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }

    func style() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        nicknameTextField.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.cornerRadius = 6
        nicknameTextField.setLeftPaddingPoints(10)
        nicknameTextField.setRightPaddingPoints(73)
        
        nicknameTextField.text = userInfo?.nickName ?? ""
        
        bioView.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        bioView.layer.borderWidth = 1
        bioView.layer.cornerRadius = 6
        
        bioTextView.text = userInfo?.introduction ?? ""
        
        updateBioTextCountLabel(length: bioTextView.text.count)
        
        if let profileImageUrl = userInfo?.imageUrl {
            let url = URL(string: profileImageUrl)
            profileImageView.kf.setImage(with: url)
        }
        
    }
    
    func updateBioTextCountLabel(length: Int) {
        let fullText = "\(length) / 150"

        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: String(length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        bioTextCoundLabel.attributedText = attributedString
    }
}

// MARK: - UITextView
extension ProfileEditViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            textView.text = memoTextViewPlaceholder
//            textView.textColor = UIColor(named: "Main")
            updateBioTextCountLabel(length: 0)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textLength = textView.text.count + text.count
        let isAtLimit = textLength <= 150
        
        return isAtLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        setDoneButtonStatus()
        updateBioTextCountLabel(length: textView.text.count)
    }
}
