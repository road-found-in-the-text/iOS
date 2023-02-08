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
        
        configureNavigationBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "알림"
    }
    
    func configureTableView() {
        self.tableView.rowHeight  = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 88
        self.tableView.separatorColor = UIColor(named: "Sub4")
    }
}

// MARK: - UITableView
extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NotificationTableViewCell else {
            assert(false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
