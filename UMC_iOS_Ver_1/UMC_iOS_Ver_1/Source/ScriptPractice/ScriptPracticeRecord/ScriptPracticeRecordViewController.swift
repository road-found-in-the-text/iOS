//
//  ScriptPracticeRecordViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/11.
//

import UIKit

class ScriptPracticeRecordViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet var stepLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var firstQuestionLabel: UILabel!
    @IBOutlet var firstAnswerButtons: [UIButton]!
    
    @IBOutlet var secondQuestionLabel: UILabel!
    @IBOutlet var secondAnswerButtons: [UIButton]!
    
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var firstSelectedAnswerIndex: Int?
    var secondSelectedAnswerIndex: Int?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleAnswerButtons(firstAnswerButtons)
        styleAnswerButtons(secondAnswerButtons)
        
        styleBottomButtons()

    }
    
    // MARK: - Style
    
    func styleAnswerButtons(_ buttons: [UIButton]) {
        buttons.forEach { button in
            button.layer.cornerRadius = button.bounds.size.width / 2
        }
    }
    
    func styleAnswerButtonStatus(_ button: UIButton) {
        if button.isSelected {
            button.backgroundColor = .blue
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = .systemGray4
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    func styleBottomButtons() {
        skipButton.layer.cornerRadius = 8
        nextButton.layer.cornerRadius = 8
    }
    
    // MARK: - IBAction
    
    @IBAction func touchFirstAnswerButton(_ sender: UIButton) {
        if firstSelectedAnswerIndex != nil {
            if sender.isSelected {
                sender.isSelected = false
                styleAnswerButtonStatus(sender)
                firstSelectedAnswerIndex = nil
            } else {
                let previousSelectedButton = firstAnswerButtons[firstSelectedAnswerIndex!]
                
                sender.isSelected = true
                previousSelectedButton.isSelected = false
                
                styleAnswerButtonStatus(sender)
                styleAnswerButtonStatus(previousSelectedButton)
                
                firstSelectedAnswerIndex = firstAnswerButtons.firstIndex(of: sender)
            }
        } else {
            sender.isSelected = true
            styleAnswerButtonStatus(sender)
            firstSelectedAnswerIndex = firstAnswerButtons.firstIndex(of: sender)
        }
    }
    
    @IBAction func touchSecondAnswerButton(_ sender: UIButton) {
        if secondSelectedAnswerIndex != nil {
            if sender.isSelected {
                sender.isSelected = false
                styleAnswerButtonStatus(sender)
                secondSelectedAnswerIndex = nil
            } else {
                let previousSelectedButton = secondAnswerButtons[secondSelectedAnswerIndex!]
                
                sender.isSelected = true
                previousSelectedButton.isSelected = false
                
                styleAnswerButtonStatus(sender)
                styleAnswerButtonStatus(previousSelectedButton)
                
                secondSelectedAnswerIndex = secondAnswerButtons.firstIndex(of: sender)
            }
        } else {
            sender.isSelected = true
            styleAnswerButtonStatus(sender)
            secondSelectedAnswerIndex = secondAnswerButtons.firstIndex(of: sender)
        }
    }
}
