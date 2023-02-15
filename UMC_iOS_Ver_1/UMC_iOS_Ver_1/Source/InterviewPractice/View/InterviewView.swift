//
//  InterviewView.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/28.
//

import UIKit

class InterviewView: UIView {
    
    @IBOutlet var interviewImageView: UIImageView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var blackButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadView()
        style()
    }
    
    private func loadView() {
        let view = Bundle.main.loadNibNamed("InterviewView",
                                            owner: self,
                                            options: nil)?.first as! UIView
        view.frame = bounds
        addSubview(view)
        
    }
    
    func style() {
        interviewImageView.layer.shadowOpacity = 0.1
        interviewImageView.layer.shadowColor = UIColor.black.cgColor
        interviewImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        backgroundView.layer.cornerRadius = 12
        backgroundView.layer.shadowOpacity = 0.1
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        blackButton.layer.cornerRadius = 8
    }
}
