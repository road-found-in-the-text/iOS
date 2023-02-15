//
//  MyPagePostTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

class MyPagePostTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    @IBOutlet var iconImageView: [UIImageView]!
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.forEach{ imageView in
            imageView.setImageColor(color: UIColor(named: "Sub2") ?? UIColor())
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
