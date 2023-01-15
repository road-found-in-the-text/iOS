//
//  ScriptPracticeRecordResultViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/16.
//

import UIKit

import Charts

class ScriptPracticeRecordResultViewController: UIViewController {
    
    // MARK: - Properteis
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBOutlet var resultChartView: RadarChartView!
    
    @IBOutlet var memoView: UIView!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var memoTextCountLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    private let memoTextViewPlaceholder = "내용을 입력해주세요."

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        self.dismissKeyboardWhenTappedAround()
        
        style()
    }
    
    func style() {
        memoView.layer.cornerRadius = 8
        memoView.layer.borderColor = UIColor(named: "Sub4")?.cgColor
        memoView.layer.borderWidth = 1
        
        doneButton.layer.cornerRadius = 8
        
        updateMemoTextCountLabel(length: 0)
    }
    
    func updateMemoTextCountLabel(length: Int) {
        
        let fullText = "\(length) / 60"

        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: String(length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        memoTextCountLabel.attributedText = attributedString
    }
}

// MARK: - UITextViewDelegate
extension ScriptPracticeRecordResultViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == memoTextViewPlaceholder {
            textView.text = nil
            textView.textColor = UIColor(named: "Sub1")
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = memoTextViewPlaceholder
            textView.textColor = UIColor(named: "Sub2")
            updateMemoTextCountLabel(length: 0)
        }
    }
}
