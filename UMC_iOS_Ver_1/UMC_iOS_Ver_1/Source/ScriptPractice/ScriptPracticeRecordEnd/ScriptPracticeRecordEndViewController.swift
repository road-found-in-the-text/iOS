//
//  ScriptPracticeRecordEndViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/23.
//

import UIKit

import Lottie

class ScriptPracticeRecordEndViewController: UIViewController {
    
    @IBOutlet var animationView: LottieAnimationView!
    @IBOutlet var againButton: UIButton!
    @IBOutlet var resultButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureAnimationView()
        styleButton()
    }
    
    func configureAnimationView() {
        let customAnimationView = LottieAnimationView(name: "ThumbsUp")
        
        customAnimationView.frame = animationView.bounds
        customAnimationView.contentMode = .scaleAspectFit
        
        customAnimationView.loopMode = .loop
        customAnimationView.play()
        animationView.addSubview(customAnimationView)
    }
    
    func styleButton() {
        againButton.layer.cornerRadius = 8
        resultButton.layer.cornerRadius = 8
    }
    
    @IBAction func bottomButtonTapped(_ sender: UIButton) {
        for viewController in self.navigationController!.viewControllers as Array {
            if let nextViewController = viewController as? ScriptEditTabmanViewController {
                nextViewController.pageIndex = sender == againButton ? 1 : 2
                print(nextViewController.pageIndex)
                self.navigationController?.popToViewController(nextViewController, animated: true)
            }
        }
    }
}
