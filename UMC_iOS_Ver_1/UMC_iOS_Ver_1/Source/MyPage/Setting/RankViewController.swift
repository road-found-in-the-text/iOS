//
//  RankViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

class RankViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let sectionHeaderIdentifier = "RankSectionHeader"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "등급"

        tableView.tableHeaderView = RankHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 229))
        tableView.register(UINib(nibName: "RankSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
    }

}

// MARK: - UITableView
extension RankViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier)
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
}
