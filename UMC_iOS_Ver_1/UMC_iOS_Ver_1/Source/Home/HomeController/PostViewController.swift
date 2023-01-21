//
//  PostViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/18.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(reportTapped))
    }
    
    @objc func reportTapped() {
        let reportStoryboard = UIStoryboard(name: Const.Storyboard.Name.report, bundle: nil)
        guard let reportVC = reportStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.report) as? ReportViewController else { return }
        present(reportVC, animated: true)
    }

}
