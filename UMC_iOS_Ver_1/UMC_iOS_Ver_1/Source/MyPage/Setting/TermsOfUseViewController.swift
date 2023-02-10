//
//  TermsOfUseViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/10.
//

import UIKit

class TermsOfUseViewController: UIViewController {
    
//    let termOfUse = """"""
    
    @IBOutlet var outView: UIView!
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let markdown = try? NSAttributedString(markdown: termOfUse) else {
            return
        }
        label.attributedText = markdown
        
    }
    
    func style() {
        outView.layer.borderColor = UIColor(named: "Sub3")?.cgColor
        outView.layer.borderWidth = 1
        outView.layer.cornerRadius = 16
    }

}
