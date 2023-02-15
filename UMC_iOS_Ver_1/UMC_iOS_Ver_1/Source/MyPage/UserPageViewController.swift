//
//  UserPageViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class UserPageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var profileView: MyPageProfileView!
    
    private let sectionHeaderIdentifier = "sectionHeader"
    private let cellIdentifier = "postCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        setProfileView()
        
        let sectionHeaderNib = UINib(nibName: "UserPageSectionHeaderView", bundle: nil)
        tableView.register(sectionHeaderNib, forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
        
        let cellNib = UINib(nibName: "MyPagePostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.separatorColor = UIColor(named: "Sub4")
    }
    
    func setProfileView() {
        profileView = MyPageProfileView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 132))
        profileView.detailButton.isHidden = true
        
        tableView.tableHeaderView = profileView
    }

}

extension UserPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyPagePostTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier) as? UserPageSectionHeaderView else {
            return UIView()
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    
}
