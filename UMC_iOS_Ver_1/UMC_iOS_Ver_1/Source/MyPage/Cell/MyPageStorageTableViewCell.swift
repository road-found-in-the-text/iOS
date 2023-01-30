//
//  MyPageStorageTableViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

class MyPageStorageTableViewCell: UITableViewCell {
    
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0))
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
