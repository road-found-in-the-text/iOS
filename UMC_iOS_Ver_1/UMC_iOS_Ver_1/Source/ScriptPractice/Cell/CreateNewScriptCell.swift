//
//  CreateNewScriptCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/23.
//

import UIKit

protocol CellDelegate: AnyObject {
    func didTap(_ cell: UITableViewCell, name: String, content: String)
}

protocol TableViewCellDelegate: AnyObject {
    func updateTextViewHeight(_ cell: UITableViewCell,_ textView:UITextView)
}

class CreateNewScriptCell: UITableViewCell {

    weak var delegateForHeight: TableViewCellDelegate?
    
    weak var delegate: CellDelegate?
    
    @IBOutlet weak var pageNameBtn: UIButton!
    
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var contentTxtView: UITextView!
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.didTap(self, name: pageNameBtn.titleLabel?.text ?? " ", content: contentTxtView.text)
    }
    
    func setTextView() {
        contentTxtView.delegate = self
        contentTxtView.isScrollEnabled = false
        contentTxtView.sizeToFit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("실행됨 ㅇㅇ")
        setTextView()
    }
}

extension CreateNewScriptCell: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {

        if let delegate = delegateForHeight {
            delegate.updateTextViewHeight(self, textView)
        }
    }
    
}

