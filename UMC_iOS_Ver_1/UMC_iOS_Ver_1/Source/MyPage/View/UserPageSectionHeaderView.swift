//
//  UserPageSectionHeaderView.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class UserPageSectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 10)
        shadowView.layer.shadowRadius = 2
    }

}
