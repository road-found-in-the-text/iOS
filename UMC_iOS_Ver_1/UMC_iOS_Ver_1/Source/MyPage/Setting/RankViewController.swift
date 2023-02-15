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
    
    var userRank: String?
    
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
        
        configureTableView()
    }
    
    func configureTableView() {
        let tableViewHeader = RankHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 229))
        
        if let userRank = userRank {
            tableViewHeader.rankImageView.image = UIImage(named: "Rank \(userRank.capitalized)")
            tableViewHeader.rankLabel.text = getRankKoreanName()
        }
        
        tableView.tableHeaderView = tableViewHeader
        tableView.register(UINib(nibName: "RankSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: sectionHeaderIdentifier)
    }
    
    func getRankKoreanName() -> String {
        guard let userRank = userRank else {
            return "등급"
        }
        
        switch userRank {
        case "BRONZE":
            return "브론즈"
        case "SILVER":
            return "실버"
        case "GOLD":
            return "골드"
        case "PLATINUM":
            return "플래티넘"
        case "DIAMOND":
            return "다이아몬드"
        default:
            return "등급"
        }
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
        
        if let userRank = userRank {
            if rank.image == userRank.capitalized {
                cell.myRankLabel.isHidden = false
            }
        }
        
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
