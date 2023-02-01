//
//  CustomAlertViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/19.
//

import UIKit

class CustomAlertViewController: UIViewController {

    @IBOutlet weak var reportAlertView: UIView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayer()
    }

    //테두리 설정
    func setLayer() {
        reportAlertView.layer.cornerRadius = 10
        reportButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
    }
    
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        guard let reportContent = ReportViewController.reportContent else { return }
        print(reportContent)
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
}
