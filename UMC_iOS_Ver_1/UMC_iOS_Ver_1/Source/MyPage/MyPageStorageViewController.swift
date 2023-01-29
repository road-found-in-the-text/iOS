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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerNib = UINib(nibName: "MyPageStorageTableHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerViewIdentifier)
    }
}

extension MyPageStorageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerViewIdentifier) as? MyPageStorageTableHeaderView else {
            return UIView()
        }
                
        return header
    }
}
