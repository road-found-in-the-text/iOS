//
//  SettingViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let sectionTitle = ["내 계정", "앱 설정", "글에서 발견한 길 응원하기", "약관 및 정책", "계정 관리"]
    private let sectionMenuTitle = [
        ["이메일", "프로필 수정"],
        ["알림", "언어"],
        ["스토어 리뷰 남기기", "건의함"],
        ["이용약관", "개인정보 처리방침"],
        ["비밀번호 변경", "로그아웃", "계정탈퇴"]
    ]
    private var nextViewControllers = [[UIViewController]]()
    
    private let sectionHeaderIdentifier = "SectionHeader"
    private let cellIdentifier = "SettingCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "설정"
        self.navigationItem.backButtonTitle = ""
    }
    
    func configureTableView() {
        let sectionHeader = UINib(nibName: "SettingHeaderView", bundle: nil)
        tableView.register(sectionHeader, forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
    }
    
    func setNextViewControllers() {
        guard let alarmViewController = storyboard?.instantiateViewController(withIdentifier: "AlarmViewController") as? AlarmViewController else {
            assert(false)
        }
        
//        nextViewControllers.append(alarmViewController)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section != 4 ? 2 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SettingTableViewCell else {
            assert(false)
        }
        
        cell.titleLabel.text = sectionMenuTitle[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.emailLabel.isHidden = false
            cell.emailLabel.text = "email"
            cell.chevronImageView.isHidden = true
        } else if indexPath.section == 4 {
            if indexPath.row == 1 {
                cell.titleLabel.textColor = .systemBlue
            } else if indexPath.row == 2 {
                cell.titleLabel.textColor = .systemRed
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier) as? SettingHeaderView else {
            return UIView()
        }
        if section == 0 {
            header.separatorView.isHidden = true
        }
        
        header.titleLabel.text = sectionTitle[section]
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let languageViewController = storyboard?.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController else {
            assert(false)
        }
        navigationController?.pushViewController(languageViewController, animated: true)
    }
    
    
}
