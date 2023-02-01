//
//  PostCommentsTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/25.
//

import UIKit

class PostCommentsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
