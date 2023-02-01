//
//  BestForumCollectionViewCell.swift
//  project
//
//  Created by 왕정빈 on 2023/01/06.
//

import UIKit

class BestForumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bestForumImage: UIImageView!
    @IBOutlet weak var bestForumTitleLabel: UILabel!
    @IBOutlet weak var numOfBestForumPhotosLabel: UILabel!
    @IBOutlet weak var numOfBestForumCommentsLabel: UILabel!
    @IBOutlet weak var numOfBestForumLikesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
