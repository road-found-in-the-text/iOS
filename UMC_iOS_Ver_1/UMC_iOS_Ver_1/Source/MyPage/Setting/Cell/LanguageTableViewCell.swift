//
//  LanguageTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var checkImageView: UIImageView!
    @IBOutlet var temporaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        temporaryLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
