//
//  RankHeaderView.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

class RankHeaderView: UIView {
    
    @IBOutlet var rankImageView: UIImageView!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var scriptCountLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    private func loadView() {
        let view = Bundle.main.loadNibNamed("RankHeaderView",
                                            owner: self,
                                            options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
    }

}
