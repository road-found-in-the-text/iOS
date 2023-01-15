//
//  ScriptPracticeRecordResultViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/16.
//

import UIKit

import Charts

class ScriptPracticeRecordResultViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var resultChartView: RadarChartView!
    
    @IBOutlet var memoView: UIView!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var memoTextCountLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        style()
    }
    
    func style() {
        memoView.layer.cornerRadius = 8
        memoView.layer.borderColor = UIColor(named: "Sub4")?.cgColor
        memoView.layer.borderWidth = 1
        
        doneButton.layer.cornerRadius = 8
        
        styleTextCountLabel(length: "0")
    }
    
    func styleTextCountLabel(length: String) {
        let fullText = length + " / 60"

        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: length)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        memoTextCountLabel.attributedText = attributedString
    }
}
