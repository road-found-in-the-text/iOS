//
//  ForumTableViewCell.swift
//  project
//
//  Created by 왕정빈 on 2023/01/08.
//

import UIKit

class ForumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var forumTitleLabel: UILabel!
    @IBOutlet weak var forumContentLabel: UILabel!
    @IBOutlet weak var forumNickNameAndUploadTime: UILabel!
    @IBOutlet weak var numOfForumPhotosLabel: UILabel!
    @IBOutlet weak var numOfForumCommentsLabel: UILabel!
    @IBOutlet weak var numOfForumLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
