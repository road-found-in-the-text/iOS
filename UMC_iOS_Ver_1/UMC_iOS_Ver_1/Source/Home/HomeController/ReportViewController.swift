//
//  ReportViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/17.
//

import UIKit
import DLRadioButton

class ReportViewController: UIViewController {
    
    static var reportContent: String?
    private let textViewPlaceholder = "신고 사유를 입력해주세요."
    
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var etcReportTextView: UITextView!
    @IBOutlet weak var reportOptionButton1: DLRadioButton!
    @IBOutlet weak var reportOptionButton2: DLRadioButton!
    @IBOutlet weak var reportOptionButton3: DLRadioButton!
    @IBOutlet weak var reportOptionButton4: DLRadioButton!
    @IBOutlet weak var reportOptionButton5: DLRadioButton!
    @IBOutlet weak var reportOptionButton6: DLRadioButton!
    @IBOutlet weak var reportOptionButton7: DLRadioButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        etcReportTextView.delegate = self
        reportButton.layer.cornerRadius = 10
        settingTextView()
        setReportButton()
    }
    
    //report 체크 버튼 기본 설정
    func setReportButton() {
        reportOptionButton1.setTitle("낚시/놀람/도배", for: .normal)
        reportOptionButton2.setTitle("정당/정치인 비하 및 선거운동", for: .normal)
        reportOptionButton3.setTitle("음란물/불건전한 만남 및 대화", for: .normal)
        reportOptionButton4.setTitle("유출/사칭/사기", for: .normal)
        reportOptionButton5.setTitle("욕설/비하", for: .normal)
        reportOptionButton6.setTitle("상업적 광고 및 판매", for: .normal)
        reportOptionButton7.setTitle("기타", for: .normal)
        reportOptionButton1.addTarget(self, action: #selector(reportOptionButtonTap(_:)), for: .touchUpInside)
        reportOptionButton2.addTarget(self, action: #selector(reportOptionButtonTap(_:)), for: .touchUpInside)
        reportOptionButton3.addTarget(self, action: #selector(reportOptionButtonTap(_:)), for: .touchUpInside)
        reportOptionButton4.addTarget(self, action: #selector(reportOptionButtonTap(_:)), for: .touchUpInside)
        reportOptionButton5.addTarget(self, action: #selector(reportOptionButtonTap(_:)), for: .touchUpInside)
        reportOptionButton6.addTarget(self, action: #selector(reportOptionButtonTap(_:)), for: .touchUpInside)
        reportOptionButton7.addTarget(self, action: #selector(reportEtcButtonTap(_:)), for: .touchUpInside)
    }
    
    //화면 클릭시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func reportOptionButtonTap(_ sender:DLRadioButton) {
        ReportViewController.reportContent = sender.currentTitle!
        etcReportTextView.isEditable = false
    }
    
    @objc func reportEtcButtonTap(_ sender:DLRadioButton) {
        etcReportTextView.isEditable = true
        etcReportTextView.isUserInteractionEnabled = true
    }
    
    //textView 글자 수 update
    func updateMemoTextCountLabel(length: Int) {
        let fullText = "\(length) / 80"
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: String(length))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        textCountLabel.attributedText = attributedString
    }
    
    //textView 테두리 설정
    func settingTextView() {
        etcReportTextView.layer.borderWidth = 0.3
        etcReportTextView.layer.borderColor = UIColor.black.cgColor
        etcReportTextView.layer.cornerRadius = 10
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    //신고하기 버튼 클릭 시 팝업 창 띄우기
    @IBAction func reportButtonTapped(_ sender: Any) {
        let alertStoryboard = UIStoryboard(name: Const.Storyboard.Name.reportAlert, bundle: nil)
        guard let alertVC = alertStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.reportAlert) as? CustomAlertViewController else { return }
        present(alertVC, animated: false)
    }
    
    
}

extension ReportViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = UIColor(named: "Sub2")
            updateMemoTextCountLabel(length: 0)
        } else {
            ReportViewController.reportContent = textView.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textLength = textView.text.count + text.count
        let isAtLimit = textLength <= 80
        return isAtLimit
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateMemoTextCountLabel(length: textView.text.count)
    }
}
