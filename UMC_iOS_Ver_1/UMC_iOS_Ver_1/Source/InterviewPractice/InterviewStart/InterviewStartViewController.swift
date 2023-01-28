//
//  InterviewStartViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/28.
//

import UIKit

class InterviewStartViewController: UIViewController {
    
    @IBOutlet var interviewView: InterviewView!

    override func viewDidLoad() {
        super.viewDidLoad()

        interviewView.blackButton.addTarget(self, action: #selector(blackButtonTapped), for: .touchUpInside)
    }
    
    @objc func blackButtonTapped() {
        print("tapped")
    }
}
