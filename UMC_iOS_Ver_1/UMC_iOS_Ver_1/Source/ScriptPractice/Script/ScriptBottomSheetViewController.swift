//
//  ScriptBottomSheetViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/18.
//

import UIKit

class ScriptBottomSheetViewController: UIViewController {
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var practiceStartButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "목표시간 설정"
        practiceStartButton.layer.cornerRadius = 8
    }

}
