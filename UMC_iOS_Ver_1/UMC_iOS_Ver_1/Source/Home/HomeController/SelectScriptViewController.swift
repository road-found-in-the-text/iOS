//
//  SelectScriptViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/31.
//

import UIKit

class SelectScriptViewController: UIViewController {
    
    @IBOutlet weak var entireButton: UIButton!
    @IBOutlet weak var scriptButton: UIButton!
    @IBOutlet weak var interviewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundCornerButton()
    }
    
    func roundCornerButton() {
        entireButton.layer.cornerRadius = 20
        scriptButton.layer.cornerRadius = 20
        interviewButton.layer.cornerRadius = 20
        entireButton.layer.shadowColor = UIColor.black.cgColor
        entireButton.layer.shadowOpacity = 0.3
        entireButton.layer.shadowOffset = CGSize.zero
        entireButton.layer.shadowRadius = 2
        scriptButton.layer.shadowColor = UIColor.black.cgColor
        scriptButton.layer.shadowOpacity = 0.3
        scriptButton.layer.shadowOffset = CGSize.zero
        scriptButton.layer.shadowRadius = 2
        interviewButton.layer.shadowColor = UIColor.black.cgColor
        interviewButton.layer.shadowOpacity = 0.3
        interviewButton.layer.shadowOffset = CGSize.zero
        interviewButton.layer.shadowRadius = 2
    }
    
    func buttonSelected(a: UIButton, b: UIButton, c: UIButton) {
        a.backgroundColor = UIColor.black
        a.configuration?.baseForegroundColor = UIColor.white
        b.backgroundColor = UIColor.white
        b.titleLabel?.textColor = UIColor.black
        c.backgroundColor = UIColor.white
        c.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func viewSelectButtonTapped(_ sender: UIButton) {
        if sender == entireButton {
            buttonSelected(a: entireButton, b: scriptButton, c: interviewButton)
        } else if sender == scriptButton {
            buttonSelected(a: scriptButton, b: entireButton, c: interviewButton)
        } else {
            buttonSelected(a: interviewButton, b: entireButton, c: scriptButton)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func completeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
