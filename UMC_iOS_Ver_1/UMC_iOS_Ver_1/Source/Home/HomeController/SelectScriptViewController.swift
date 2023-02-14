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
    @IBOutlet weak var selectScriptTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectScriptTableView.delegate = self
        selectScriptTableView.dataSource = self
        
        selectScriptTableView.separatorStyle = .none
        
        roundCornerButton()
    }
    
    // MARK: - 스크립트 분류 버튼 설정
    
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

// MARK: - 스크립트 목록 tableView 설정

extension SelectScriptViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let scriptCheckCell = tableView.dequeueReusableCell(withIdentifier: "ScriptCheckTableViewCell") as? ScriptCheckTableViewCell else { return UITableViewCell() }
        scriptCheckCell.selectionStyle = .none
        
        guard let interviewCheckCell = tableView.dequeueReusableCell(withIdentifier: "InterviewCheckTableViewCell") as? InterviewCheckTableViewCell else { return UITableViewCell() }
        return scriptCheckCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectScripCell = tableView.cellForRow(at: indexPath) as? ScriptCheckTableViewCell else { return }
        if selectScripCell.checkBox.image == UIImage(named: "ic_CheckBox_UnSelected") {
            selectScripCell.checkBox.image = UIImage(named: "ic_check square")
        } else {
            selectScripCell.checkBox.image = UIImage(named: "ic_CheckBox_UnSelected")
        }
    }
}
