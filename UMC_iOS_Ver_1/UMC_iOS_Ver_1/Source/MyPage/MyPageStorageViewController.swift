//
//  MyPageStorageViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/29.
//

import UIKit

class MyPageStorageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let headerViewIdentifier = "storageHeader"
    private let cellIdentifier = "storageCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewHeader()
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0
        }
    }
    
    func registerTableViewHeader() {
        let headerNib = UINib(nibName: "MyPageStorageTableHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
    }
}

extension MyPageStorageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyPageStorageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.typeLabel.text = "어쩌고저쩌고"
        cell.setTypeViewWidth()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as? MyPageStorageTableHeaderView else {
            return UIView()
        }
                
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
}
