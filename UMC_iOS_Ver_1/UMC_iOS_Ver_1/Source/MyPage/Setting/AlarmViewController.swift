//
//  AlarmViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class AlarmViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let cellIdentifier = "AlarmCell"
    private let cellContents = [
        ["활동 알림", "좋아요, 댓글 등 내 활동 알림을 받을 수 있어요."],
        ["마케팅 알림", "앱의 이벤트 정보를 빠르게 받을 수 있어요."]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configureTableView()
    }
    
    func configureTableView() {
    }
}

extension AlarmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AlarmTableViewCell else {
            assert(false)
        }
        
        cell.titleLabel.text = cellContents[indexPath.row][0]
        cell.descriptionLabel.text = cellContents[indexPath.row][1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
