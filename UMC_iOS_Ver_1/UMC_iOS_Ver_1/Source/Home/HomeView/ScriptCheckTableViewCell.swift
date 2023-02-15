//
//  ScriptCheckTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/02/06.
//

import UIKit

class ScriptCheckTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
