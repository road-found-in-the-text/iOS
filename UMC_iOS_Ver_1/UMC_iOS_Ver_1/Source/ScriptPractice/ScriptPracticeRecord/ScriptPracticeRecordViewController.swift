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
    
    let questions = [
        PracticeQuestion(title: "분석력", firstQuestion: "주제와 관련된 내용을 보여주는가?", secondQuestion: "주제를 벗어나지 않았는가?"),
        PracticeQuestion(title: "논리력", firstQuestion: "주장의 논리가 모호하지 않은가?", secondQuestion: "근거 없는 주장을 하고 있지는 않은가?"), PracticeQuestion(title: "창의력", firstQuestion: "독창적인 내용을 보여주는가?", secondQuestion: "모두가 공감할 수 있는 내용인가?"),
        PracticeQuestion(title: "전달력", firstQuestion: "주어진 발표 시간을 잘 준수했는가?", secondQuestion: "발표 내용을 이해하기 쉽고 명확하게 전달했는가?"),
        PracticeQuestion(title: "전문성", firstQuestion: "발표 내용이 다른 학습자의 학습에 도움이 되었는가?", secondQuestion: "청중의 수준에 맞는 내용을 설명하였는가?")
    ]
    
    var elapsedTime: Int?
    
    var currentQuestionNumber = 1
    var selectedAnswer = Array(repeating: PracticeAnswer(), count: 5)
    
    var firstSelectedAnswerIndex: Int?
    var secondSelectedAnswerIndex: Int?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
              
        configureNavigationItem()
        styleAnswerButtons(firstAnswerButtons)
        styleAnswerButtons(secondAnswerButtons)
        
        styleBottomButtons()

    }
    
    func configureNavigationItem() {
        self.navigationItem.title = "연습 기록"
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_delete"), style: .plain, target: self, action: #selector(closeButtonTapped))
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc func closeButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Style
    
    func styleAnswerButtons(_ buttons: [UIButton]) {
        buttons.forEach { button in
            button.layer.cornerRadius = button.bounds.size.width / 2
        }
    }
    
    func styleAnswerButtonStatus(_ button: UIButton) {
        if button.isSelected {
            button.backgroundColor = UIColor(named: "Sub1")
            button.setTitleColor(.white, for: .normal)
        } else {
            button.backgroundColor = UIColor(named: "Sub4")
            button.setTitleColor(UIColor(named: "Sub2"), for: .normal)
        }
    }
    
    func styleBottomButtons() {
        skipButton.layer.cornerRadius = 8
        nextButton.layer.cornerRadius = 8
    }
    
    // MARK: - Update Status
    func updateQuestionContent() {
        let question = questions[currentQuestionNumber-1]
        
        stepLabel.text = "\(currentQuestionNumber)/\(questions.count)"
        titleLabel.text = "\(currentQuestionNumber). \(question.title)"
        firstQuestionLabel.text = question.firstQuestion
        secondQuestionLabel.text = question.secondQuestion
    }
    
    func updateSelectedAnswer() {
        // 선택 했거나 안했거나..
        // 선택된 답변 내용이 유지되어야 함..
        if let previousFirstSelectedIndex = firstSelectedAnswerIndex {
            firstAnswerButtons[previousFirstSelectedIndex].isSelected = false
        }
        if let previousSecondSelectedIndex = secondSelectedAnswerIndex {
            secondAnswerButtons[previousSecondSelectedIndex].isSelected = false
        }
        
        if let currentFirstSelectedAnswer = selectedAnswer[currentQuestionNumber - 1].firstAnswer {
            firstAnswerButtons[currentFirstSelectedAnswer - 1].isSelected = true
            firstSelectedAnswerIndex = currentFirstSelectedAnswer - 1
        } else {
            firstSelectedAnswerIndex = nil
        }
        
        if let currentSecondSelectedAnswer = selectedAnswer[currentQuestionNumber - 1].secondAnswer {
            secondAnswerButtons[currentSecondSelectedAnswer - 1].isSelected = true
            secondSelectedAnswerIndex = currentSecondSelectedAnswer - 1
        } else {
            secondSelectedAnswerIndex = nil
        }
        
        firstAnswerButtons.forEach{ button in
            styleAnswerButtonStatus(button)
        }
        
        secondAnswerButtons.forEach{ button in
            styleAnswerButtonStatus(button)
        }        
    }
    
    func updateSkipButtonTitle() {
        if currentQuestionNumber == 1 {
            skipButton.setTitle("건너뛰기", for: .normal)
        } else {
            skipButton.setTitle("이전", for: .normal)
        }
    }
    
    func presentLoadingViewController() {
        let storyboard = UIStoryboard(name: "ScriptPracticeRecordRoading", bundle: nil)
        guard let loadingViewController = storyboard.instantiateViewController(withIdentifier: "ScriptPracticeRecordRoadingViewController") as? ScriptPracticeRecordRoadingViewController else {
            assert(false)
        }
        
        loadingViewController.elapsedTime = elapsedTime
        loadingViewController.answer = selectedAnswer
        loadingViewController.modalPresentationStyle = .fullScreen
        loadingViewController.delegate = self
        
        self.present(loadingViewController, animated: false)
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
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        if currentQuestionNumber == 1 {
            presentLoadingViewController()
        } else {
            currentQuestionNumber -= 1
            
            updateSkipButtonTitle()
            updateQuestionContent()
            updateSelectedAnswer()
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentQuestionNumber < questions.count {
            guard let firstSelectedAnswerIndex = firstSelectedAnswerIndex, let secondSelectedAnswerIndex = secondSelectedAnswerIndex else {
                return
            }
            selectedAnswer[currentQuestionNumber-1].firstAnswer = firstSelectedAnswerIndex + 1
            selectedAnswer[currentQuestionNumber-1].secondAnswer = secondSelectedAnswerIndex + 1

            currentQuestionNumber += 1

            updateSkipButtonTitle()
            updateQuestionContent()
            updateSelectedAnswer()
        } else {
            guard let firstSelectedAnswerIndex = firstSelectedAnswerIndex, let secondSelectedAnswerIndex = secondSelectedAnswerIndex else {
                return
            }
            
            selectedAnswer[currentQuestionNumber-1].firstAnswer = firstSelectedAnswerIndex + 1
            selectedAnswer[currentQuestionNumber-1].secondAnswer = secondSelectedAnswerIndex + 1

            presentLoadingViewController()
        }
    }
}

extension ScriptPracticeRecordViewController: ScriptPracticeRecordLoadingProtocol {
    func didFinishLoading() {
        let storyboard = UIStoryboard(name: "ScriptPracticeRecordResult", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ScriptPracticeRecordResultViewController") as? ScriptPracticeRecordResultViewController else {
            assert(false)
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
