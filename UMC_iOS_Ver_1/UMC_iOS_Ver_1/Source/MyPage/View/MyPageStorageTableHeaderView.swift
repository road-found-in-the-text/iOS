//
//  MyPageStorageTableHeaderView.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/29.
//

import UIKit

class MyPageStorageTableHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet var categoryButtons: [UIButton]!
    @IBOutlet var selectedCategoryLabel: UILabel!
    @IBOutlet var selectedCellAmountLabel: UILabel!
    
    var selectedButtonIndex = 0
    let categoryName = ["전체", "대본", "면접"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }
    
    func style() {
        categoryButtons.forEach { button in
            button.layer.cornerRadius = button.frame.height / 2
            button.layer.borderColor = UIColor(named: "Sub3")?.cgColor
            button.layer.borderWidth = 1
            button.layer.shadowOpacity = 0.1
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
        categoryButtons[0].isSelected = true
        styleButtonStatus(categoryButtons[0])
    }
    
    func styleButtonStatus(_ button: UIButton) {
        if button.isSelected {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .white
            button.setTitleColor(UIColor(named: "Sub1"), for: .normal)
        }
    }
    
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        guard categoryButtons[selectedButtonIndex] != sender else { return }
        
        let previousSelectedButton = categoryButtons[selectedButtonIndex]
        
        sender.isSelected = true
        previousSelectedButton.isSelected = false
        
        styleButtonStatus(sender)
        styleButtonStatus(previousSelectedButton)
        
        selectedButtonIndex = categoryButtons.firstIndex(of: sender)!
        
        selectedCategoryLabel.text = categoryName[selectedButtonIndex]
    }

}
