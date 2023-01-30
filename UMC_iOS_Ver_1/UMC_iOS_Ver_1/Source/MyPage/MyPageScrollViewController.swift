//
//  MyPageScrollViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

import HPParallaxHeader

class MyPageScrollViewController: HPScrollViewController {
    
    @IBOutlet var profileView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerView = profileView
        headerHeight = 180
    }

}
