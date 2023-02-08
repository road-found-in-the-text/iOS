//
//  SettingTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var chevronImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        emailLabel.isHidden = true
        chevronImageView.setImageColor(color: UIColor(named: "Sub2") ?? UIColor())
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
