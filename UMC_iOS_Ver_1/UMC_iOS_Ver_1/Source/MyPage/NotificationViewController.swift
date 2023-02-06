//
//  NotificationViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let cellIdentifier = "NotificationCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "알림"
        // TODO: - tableview 높이 동적 조절
//        self.tableView.rowHeight  = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 88
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NotificationTableViewCell else {
            assert(false)
        }
        
        if indexPath.row % 2 == 0 {
            cell.commentLabel.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
