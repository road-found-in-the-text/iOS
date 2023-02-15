//
//  RankViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

struct RankInfo {
    let image: String
    let name: String
    let scriptCount: String
}

class RankViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let rankInfo = [
        RankInfo(image: "Bronze", name: "브론즈", scriptCount: "0"),
        RankInfo(image: "Silver", name: "실버", scriptCount: "3"),
        RankInfo(image: "Gold", name: "골드", scriptCount: "10"),
        RankInfo(image: "Platinum", name: "플래티넘", scriptCount: "20"),
        RankInfo(image: "Diamond", name: "다이아몬드", scriptCount: "50")
    ]
    
    private let sectionHeaderIdentifier = "RankSectionHeader"
    private let cellIdentifier = "RankCell"

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
        return rankInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RankTableViewCell else {
            assert(false)
        }
        
        let rank = rankInfo[indexPath.row]
        
        cell.rankImageView.image = UIImage(named: "Rank \(rank.image)")
        cell.rankLabel.text = rank.name
        cell.scriptCountLabel.text = "스크립트 \(rank.scriptCount)개 이상"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderIdentifier)
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
}
