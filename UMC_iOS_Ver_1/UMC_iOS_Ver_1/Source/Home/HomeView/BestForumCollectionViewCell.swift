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
    @IBOutlet var iconImageViews: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bestForumImage.layer.cornerRadius = 10
        
        //Cell에 그림자 효과
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 2
        
        //Cell round corner
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        // 아이콘 이미지 색상 설정
        iconImageViews.forEach { imageView in
            imageView.setImageColor(color: UIColor(named: "Sub2") ?? UIColor())
        }
    }

}
