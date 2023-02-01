//
//  WriteScriptViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/23.
//

import UIKit

class WriteScriptViewController: UIViewController {

    var pageCount = 0 //지금 무슨 페이진지 아울렛 변수에 띄워주기위한 변수
    
    var originPageName = ""
    
    var originPageContent = ""
    
    @IBOutlet weak var pageNameTxtField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!//내용적는 텍스트뷰
    
    @IBOutlet weak var PageNumLabel: UILabel!
    
    @IBOutlet weak var boldBtn: UIButton!
    
    var confirmChange = false //문단 끝에 폰트 바꿨을때 자꾸 이어지는걸 방지하기 위함
    
    //단어 선택시 index 알아내기 위한 변수들
    var startTextIndex = 0
    var endTextIndex = 0
    
    //지금 내가 쓰고있는 컨텐츠 담겨있는 String
    var contentString = String()
    
    var boldStringList = [String]()
    
    @objc func didTapCompleteBtn(_ sender: UIButton) {
        
        print("저장")
    }
    
    //네비게이션 바 (저장) 버튼 색상 바꿔주기위한 감시 함수
    @objc func isConditionComplete(_ textField: UITextField) {
        //수정사항있으면 네이게이션 버튼 색 바뀜
        if (originPageName == pageNameTxtField.text) && (originPageContent == contentTextView.text){
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
        }
        else{
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        }
        
    }
    
    
    @IBAction func didTapChangeBoldBtn(_ sender: Any) {
        
        // contentTextView의 텍스트를 가지고 옵니다.
        guard let text = self.contentTextView.text else { return }

        // contentTextView의 text로 NSMutableAttributedString 인스턴스를 만들어줍니다.
        let attributeString = NSMutableAttributedString(string: text)

        // 적용할 글자 크기와 폰트를 설정합니다.
        let font = UIFont.boldSystemFont(ofSize: 14)

        //현재 내가 선택한 텍스트
        let textSelect = contentString.substring(from: startTextIndex, to: endTextIndex)
        
        boldStringList.append(textSelect)
        
        // Pingu에만 방금 만든 폰트를 적용합니다.
        for i in 0 ..< boldStringList.count {
            attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: boldStringList[i], range: NSRange(location: 0, length: 3)))
        }
        
        var stringForServer = "~안녕하세요~ *신태원*입니다."
        
        
        // myLabel에 방금 만든 속성을 적용합니다.
        self.contentTextView.attributedText = attributeString
        
        //체크 한번 해줘야됨!
        confirmChange = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //화면 전환하자마자 키보드 올리기
        pageNameTxtField.becomeFirstResponder()
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        //네이게이션 타이틀 선언
        title = "내용 작성"

        //네비게이션바에 아이템달고 색깔 지정해줌
        _ = [NSAttributedString.Key.foregroundColor:UIColor(hex: 0xADB5BD
)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(didTapCompleteBtn))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
        
        //페이지 넘버링 해줌
        if pageCount < 9 {
            PageNumLabel.text = "0" + String(pageCount)
        }
        else{
            PageNumLabel.text = String(pageCount)
        }
        
        //위에서 만든 감시함수 적용
        pageNameTxtField.addTarget(self, action: #selector(WriteScriptViewController.isConditionComplete(_:)), for: .editingChanged)

        //텍스트뷰 초기설정
        contentTextView.delegate = self
        contentTextView.text = "내용을 작성하세요."
        contentTextView.textColor = UIColor.placeholderText
        
        }
        
    
    }

extension WriteScriptViewController: UITextViewDelegate {
    // MARK: textview 높이 자동조절
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        //textView.translatesAutoresizingMaskIntoConstraints = true
        textView.isScrollEnabled = false
        
        textView.constraints.forEach { (constraint) in
        
        // 180 이하일때는 더 이상 줄어들지 않게하기
        if estimatedSize.height <= 180 {
        
        }
        else {
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
            
        }
        
        //수정사항있으면 네이게이션 버튼 색 바뀜
        if (originPageName == pageNameTxtField.text) && (originPageContent == contentTextView.text){
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
        }
        else{
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      if textView.textColor == UIColor.placeholderText {
        textView.text = nil
        textView.textColor = UIColor.black
      }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
        textView.text = "내용을 작성하세요."
        textView.textColor = UIColor.placeholderText
      }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        
        if confirmChange == false {
            boldBtn.sendActions(for: .touchUpInside)
            confirmChange = true
        }
        
        
        contentString = textView.text
        startTextIndex = textView.selectedRange.lowerBound
        
        endTextIndex = textView.selectedRange.upperBound
        
        
    }
    
}

