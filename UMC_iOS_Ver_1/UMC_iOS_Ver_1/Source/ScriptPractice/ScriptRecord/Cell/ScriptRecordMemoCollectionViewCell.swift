//
//  ScriptRecordMemoCollectionViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/17.
//

import UIKit

class ScriptRecordMemoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var memoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        memoView.layer.cornerRadius = 8
        memoView.layer.shadowOpacity = 0.1
        memoView.layer.shadowColor = UIColor.black.cgColor
        memoView.layer.shadowOffset = CGSize(width: 0, height: 0)
        memoView.layer.shadowRadius = 2

        memoView.layer.masksToBounds = false
    }
}
