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
    }
}
