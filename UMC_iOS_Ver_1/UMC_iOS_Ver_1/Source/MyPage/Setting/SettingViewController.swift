//
//  SettingViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let sectionTitle = ["내 계정", "앱 설정", "글에서 발견한 길 응원하기", "약관 및 정책", "게정 관리"]
    private let sectionHeaderIdentifier = "SectionHeader"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "설정"
    }
    
    func configureTableView() {
        let sectionHeader = UINib(nibName: "SettingHeaderView", bundle: nil)
        tableView.register(sectionHeader, forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section != 4 ? 2 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier) as? SettingHeaderView else {
            return UIView()
        }
        header.titleLabel.text = sectionTitle[section]
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
}
