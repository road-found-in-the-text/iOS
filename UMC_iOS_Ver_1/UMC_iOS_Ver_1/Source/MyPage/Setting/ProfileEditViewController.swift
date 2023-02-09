//
//  ProfileEditViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileEditButton: UIButton!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var bioView: UIView!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var bioTextCoundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bioTextView.delegate = self
        self.dismissKeyboardWhenTappedAround()
        style()
    }

    func style() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        nicknameTextField.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        nicknameTextField.layer.borderWidth = 1
        nicknameTextField.layer.cornerRadius = 6
        nicknameTextField.setLeftPaddingPoints(10)
        nicknameTextField.setRightPaddingPoints(73)
        
        bioView.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        bioView.layer.borderWidth = 1
        bioView.layer.cornerRadius = 6
        updateBioTextCountLabel(length: 0)
        
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
        updateBioTextCountLabel(length: textView.text.count)
    }
}
