//
//  MyPageStorageTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

class MyPageStorageTableViewCell: UITableViewCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var typeView: UIView!
    @IBOutlet var typeViewWidth: NSLayoutConstraint!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        typeView.layer.cornerRadius = 6
        
        backgroundImageView.layer.shadowOpacity = 0.1
        backgroundImageView.layer.shadowColor = UIColor.black.cgColor
        backgroundImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
    
    func setTypeViewWidth() {
        typeLabel.sizeToFit()
        typeViewWidth.constant = typeLabel.frame.width + 16
    }
    
    func setTypeViewLabelStatus(_ isHidden: Bool) {
        typeView.isHidden = isHidden
        typeView.isHidden = isHidden
    }

}
