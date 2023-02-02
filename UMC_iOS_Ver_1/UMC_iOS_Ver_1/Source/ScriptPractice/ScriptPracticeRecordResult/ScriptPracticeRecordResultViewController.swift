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
    
    @IBOutlet var resultChart: RadarChartView!
    
    @IBOutlet var memoView: UIView!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var memoTextCountLabel: UILabel!
    
    @IBOutlet var doneButton: UIButton!
    
    private let resultChartLabels = ["분석력", "논리력", "전문성", "전달력", "창의력"]
    private let memoTextViewPlaceholder = "내용을 입력해주세요."

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        self.dismissKeyboardWhenTappedAround()
        
        style()
        configureResultChart()
    }
    
    func style() {
        self.navigationItem.title = "연습 기록"
        self.navigationItem.hidesBackButton = true
                                                                                          
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
    
    func configureResultChart() {
        let backgroundDataSet = RadarChartDataSet(
            entries: [
                RadarChartDataEntry(value: 5.0),
                RadarChartDataEntry(value: 5.0),
                RadarChartDataEntry(value: 5.0),
                RadarChartDataEntry(value: 5.0),
                RadarChartDataEntry(value: 5.0),
            ]
        )
        
        let dataSet = RadarChartDataSet(
            entries: [
                RadarChartDataEntry(value: 4.0),
                RadarChartDataEntry(value: 3.0),
                RadarChartDataEntry(value: 4.0),
                RadarChartDataEntry(value: 5.0),
                RadarChartDataEntry(value: 3.0),
            ]
        )
        
        let data = RadarChartData()
        data.dataSets = [backgroundDataSet, dataSet]
        
        // Style
        resultChart.isUserInteractionEnabled = false
        resultChart.legend.enabled = false
        resultChart.webLineWidth = 0
        resultChart.innerWebColor = UIColor(named: "Sub3") ?? UIColor()
        
        backgroundDataSet.drawValuesEnabled = false
        backgroundDataSet.colors = [.clear]
        backgroundDataSet.fillColor = UIColor(named: "Sub4") ?? UIColor()
        backgroundDataSet.drawFilledEnabled = true
        
        dataSet.colors = [.systemBlue]
        dataSet.lineWidth = 2
        dataSet.drawValuesEnabled = false
        
        let xAxis = resultChart.xAxis
        xAxis.labelFont = .boldSystemFont(ofSize: 14)
        xAxis.labelTextColor = UIColor(named: "Sub1") ?? UIColor()
        xAxis.valueFormatter = IndexAxisValueFormatter(values: resultChartLabels)
        
        let yAxis = resultChart.yAxis
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 4
        yAxis.drawLabelsEnabled = false
        
        
        resultChart.data = data
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ScriptPracticeRecordEnd", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ScriptPracticeRecordEndViewController") as? ScriptPracticeRecordEndViewController else {
            assert(false)
        }
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textLength = textView.text.count + text.count
        let isAtLimit = textLength <= 60
        
        return isAtLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateMemoTextCountLabel(length: textView.text.count)
    }
}
