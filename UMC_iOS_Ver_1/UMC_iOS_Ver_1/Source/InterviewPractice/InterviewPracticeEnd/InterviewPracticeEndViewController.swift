//
//  InterviewPracticeEndViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/28.
//

import UIKit

class InterviewPracticeEndViewController: UIViewController {
    
    @IBOutlet var interviewView: InterviewView!

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        interviewView.blackButton.addTarget(self, action: #selector(blackButtonTapped), for: .touchUpInside)
    }
    
    func style() {
        interviewView.interviewImageView.image = UIImage(named: "Interviewer_Active")
        interviewView.textLabel.text = "수고하셨습니다\n답변을 분석한 결과를 확인해보세요."
        interviewView.textLabel.font = .boldSystemFont(ofSize: 16)
        interviewView.blackButton.setTitle("결과 보기", for: .normal)
    }
    
    @objc func blackButtonTapped() {
        print("tapped")
    }

}
