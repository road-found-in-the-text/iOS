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
    
//    @IBOutlet weak var contentTextView: UITextView!//내용적는 텍스트뷰
    
    @IBOutlet weak var PageNumLabel: UILabel!
    
    var confirmChange = false //문단 끝에 폰트 바꿨을때 자꾸 이어지는걸 방지하기 위함
    
    //지금 내가 쓰고있는 컨텐츠 담겨있는 String
    var contentString = String()
    
    var boldStringList = [String]()
    
    var paragraphName = String()
    var paragraphContent = String()
    
    var originParagraphName = String()
    var originParagraphContent = String()
    
    
    @objc func didTapCompleteBtn(_ sender: UIButton) {
        
        UserDefaults.standard.set(pageNameTxtField.text, forKey: paragraphName)
        UserDefaults.standard.set(textView.text, forKey: paragraphContent)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        originParagraphName = UserDefaults.standard.string(forKey: paragraphName) ?? ""
        originParagraphContent = UserDefaults.standard.string(forKey: paragraphContent) ?? ""
        dismissKeyboard()
    }
    
    //네비게이션 바 (저장) 버튼 색상 바꿔주기위한 감시 함수
    @objc func isConditionCompleteForName(_ textField: UITextField) {
        //수정사항있으면 네이게이션 버튼 색 바뀜
        
        let originParagraphName = UserDefaults.standard.string(forKey: paragraphName)
        
        if (pageNameTxtField.text != "") && (originParagraphName != pageNameTxtField.text) {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            if (self.navigationItem.rightBarButtonItem?.tintColor != UIColor.black){
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
            
        }
    }
    
    let textView: UITextView = {
            let textView = UITextView()
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.isScrollEnabled = false
            textView.translatesAutoresizingMaskIntoConstraints = false
            return textView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paragraphName = "paragraphName" + String(pageCount)
        
        paragraphContent = "paragraphContent" + String(pageCount)
        
        print(paragraphName)
        print(paragraphContent)
        
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
        pageNameTxtField.addTarget(self, action: #selector(WriteScriptViewController.isConditionCompleteForName(_:)), for: .editingChanged)

        
        //텍스트뷰 초기설정
//        contentTextView.delegate = self
//        contentTextView.text = "내용을 작성하세요."
//
//        contentTextView.textColor = UIColor.placeholderText
//        contentTextView.isScrollEnabled = false
//        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
                
        // Add text view to view
        view.addSubview(textView)
        
        // Set up text view constraints
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 76).isActive = true
        
        // Set up initial text

        print(UserDefaults.standard.string(forKey: paragraphName))
        
        print(UserDefaults.standard.string(forKey: paragraphContent))
        
        if UserDefaults.standard.string(forKey: paragraphName) != nil{
            pageNameTxtField.text = UserDefaults.standard.string(forKey: paragraphName)
        }
        else{
            pageNameTxtField.placeholder = String(pageCount) + " 페이지"
        }
            
        if UserDefaults.standard.string(forKey: paragraphContent) != nil{
            textView.text = UserDefaults.standard.string(forKey: paragraphContent)
            textView.textColor = .black
        }
        else{
            textView.text = "내용을 작성하세요."
            textView.textColor = UIColor.placeholderText
        }
        
        textView.delegate = self
        
        
    }

}

extension WriteScriptViewController: UITextViewDelegate {
    // MARK: textview 높이 자동조절
    

    // Calculate the height of the text view based on its contents
        func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            
            label.sizeToFit()
            return label.frame.height
        }
        
        // Update the height of the text view as the user types
        func textViewDidChange(_ textView: UITextView) {
            let newHeight = heightForView(text: textView.text, font: textView.font!, width: textView.frame.width)
            textView.frame.size.height = newHeight
            
            //수정사항있으면 네이게이션 버튼 색 바뀜
            if (originPageName == pageNameTxtField.text) && (originPageContent == textView.text){
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
        
        let originParagraphContent = UserDefaults.standard.string(forKey: paragraphContent)
        
        if (textView.text != "") && (originParagraphContent != textView.text) && (self.navigationItem.rightBarButtonItem?.tintColor != UIColor.black) {
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
        else{
            if (self.navigationItem.rightBarButtonItem?.tintColor != UIColor.black){
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      if textView.text.isEmpty {
        textView.text = "내용을 작성하세요."
        textView.textColor = UIColor.placeholderText
      }
    }
    

}

