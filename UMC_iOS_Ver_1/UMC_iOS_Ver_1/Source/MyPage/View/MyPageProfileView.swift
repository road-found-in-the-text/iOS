//
//  MyPageProfileView.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

class MyPageProfileView: UIView {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var rankImageView: UIImageView!
    @IBOutlet var detailButton: UIButton!
    @IBOutlet var bioLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
    }
    
    private func loadView() {
        let view = Bundle.main.loadNibNamed("MyPageProfileView",
                                            owner: self,
                                            options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        detailButton.imageView?.setImageColor(color: UIColor(named: "Sub2") ?? UIColor())
        
    }

}
