//
//  RankTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

class RankTableViewCell: UITableViewCell {
    
    @IBOutlet var rankImageView: UIImageView!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var myRankLabel: UILabel!
    @IBOutlet var scriptCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
