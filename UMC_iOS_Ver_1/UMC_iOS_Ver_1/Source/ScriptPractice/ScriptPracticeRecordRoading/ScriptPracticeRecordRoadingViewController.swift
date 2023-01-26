//
//  ScriptPracticeRecordRoadingViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/23.
//

import UIKit

import Lottie

class ScriptPracticeRecordRoadingViewController: UIViewController {
    
    @IBOutlet var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureAnimationView()
    }
    
    func configureAnimationView() {
        let customAnimationView = LottieAnimationView(name: "Loading")
        
        customAnimationView.frame = animationView.bounds
        customAnimationView.contentMode = .scaleAspectFit
        
        customAnimationView.loopMode = .loop
        customAnimationView.play()
        animationView.addSubview(customAnimationView)
    }

}
