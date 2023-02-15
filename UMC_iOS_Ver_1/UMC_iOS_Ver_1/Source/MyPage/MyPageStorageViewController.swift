//
//  MyPageStorageViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/29.
//

import UIKit

class MyPageStorageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var memberScript: MemberScript?
    private var scriptData = [Script]()
    
    private let headerViewIdentifier = "storageHeader"
    private let cellIdentifier = "storageCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewHeader()
        
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0
        }
        
        MyPageDataManager().fetchMemberScriptData(id: 1, delegate: self)
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 148
    }
    
    func registerTableViewHeader() {
        let headerNib = UINib(nibName: "MyPageStorageTableHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
    }
}

// MARK: - Networking
extension MyPageStorageViewController: MyPageStorageDelegate, ScriptEditDelegate {
    func didFetchMemberScriptData(memberScript: MemberScript) {
        self.memberScript = memberScript
        memberScript.scripts.forEach { script in
            ScriptEditDataManager().fetchScriptById(id: script.scriptId, delegate: self)
        }
    }
    
    func didFetchScriptById(result: Script) {
        self.scriptData.append(result)
        tableView.reloadData()
    }
    
}
// MARK: - UITableView
extension MyPageStorageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scriptData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyPageStorageTableViewCell else {
            return UITableViewCell()
        }

        let script = scriptData[indexPath.row]
        
        cell.titleLabel.text = script.title
        cell.contentLabel.text = script.contents
        cell.pageLabel.text = "\(script.paragraphList.count) 페이지"
        cell.timeLabel.text = Date().timeAgo(script.createdDate) + " 전"
        
        cell.typeLabel.isHidden = true
        cell.typeView.isHidden = true
//        cell.setTypeViewWidth()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as? MyPageStorageTableHeaderView else {
            return UIView()
        }
        
        header.selectedCellAmountLabel.text = "\(scriptData.count)"
                
        return header
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 148
//    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
