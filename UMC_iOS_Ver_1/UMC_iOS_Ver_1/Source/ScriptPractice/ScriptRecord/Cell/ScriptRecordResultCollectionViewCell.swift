//
//  ScriptRecordResultCollectionViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/17.
//

import UIKit

class ScriptRecordResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var averageScoreLabel: UILabel!
    @IBOutlet var totalPracticeTimeLabel: UILabel!
    @IBOutlet var backgroundStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundStackView.layer.cornerRadius = 6
    }
}
