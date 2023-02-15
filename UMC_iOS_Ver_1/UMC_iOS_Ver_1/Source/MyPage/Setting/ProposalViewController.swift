//
//  ProposalViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

class ProposalViewController: UIViewController {
    
    @IBOutlet var proposalTextView: UITextView!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    var userEmail: String?
    
    private let proposalTextViewPlaceholder = "내용을 작성해주세요."

    override func viewDidLoad() {
        super.viewDidLoad()

        dismissKeyboardWhenTappedAround()
        proposalTextView.delegate = self
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        style()
    }
    
    @objc func emailTextFieldDidChange() {
        setSendButtonStatus()
    }
    
    func setSendButtonStatus() {
        if proposalTextView.text.isExists && (emailTextField.text?.isExists ?? false) {
            sendButton.isEnabled = true
            sendButton.backgroundColor = UIColor(named: "Main")
            sendButton.setTitleColor(.white, for: .normal)
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = UIColor(named: "Sub4")
            sendButton.setTitleColor(UIColor(named: "Sub2"), for: .disabled)
        }
    }
    
    func style() {
        navigationItem.title = "건의함"
        
        proposalTextView.textContainerInset = UIEdgeInsets(top: 14, left: 8, bottom: 14, right: 8)
        proposalTextView.layer.cornerRadius = 8
        proposalTextView.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        proposalTextView.layer.borderWidth = 1
        
        emailTextField.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 6
        emailTextField.setLeftPaddingPoints(10)
        emailTextField.setRightPaddingPoints(73)
        
        emailTextField.text = userEmail ?? ""
        
        sendButton.layer.cornerRadius = 8
    }
}

extension ProposalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == proposalTextViewPlaceholder {
            textView.text = nil
            textView.textColor = UIColor(named: "Main")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = proposalTextViewPlaceholder
            textView.textColor = UIColor(named: "Sub2")
        }
    }
}
