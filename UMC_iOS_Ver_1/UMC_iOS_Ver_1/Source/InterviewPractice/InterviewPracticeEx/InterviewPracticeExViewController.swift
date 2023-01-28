//
//  InterviewPracticeExViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/24.
//

import UIKit

class InterviewPracticeExViewController: UIViewController {
    
    @IBOutlet var interviewImageView: UIImageView!
    @IBOutlet var questionBackgroundView: UIView!
    @IBOutlet var questionTitleLabel: UILabel!
    @IBOutlet var questionContentLabel: UILabel!
    
    @IBOutlet var guideLabel: UILabel!
    
    @IBOutlet var recordBackgroundView: UIView!
    @IBOutlet var recordImageView: UIImageView!
    
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var recordTimeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func style() {
        interviewImageView.layer.shadowOpacity = 0.1
        interviewImageView.layer.shadowColor = UIColor.black.cgColor
        interviewImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        questionBackgroundView.layer.cornerRadius = 12
        questionBackgroundView.layer.shadowOpacity = 0.1
        questionBackgroundView.layer.shadowColor = UIColor.black.cgColor
        questionBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        recordBackgroundView.layer.cornerRadius = recordBackgroundView.frame.width / 2
        recordBackgroundView.layer.shadowOpacity = 0.1
        recordBackgroundView.layer.shadowColor = UIColor.black.cgColor
        recordBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        recordImageView.image = UIImage(named: "ic_ interview")
        recordImageView.setImageColor(color: .systemBlue)
        
        recordTimeLabel.isHidden = true
        
    }
}
