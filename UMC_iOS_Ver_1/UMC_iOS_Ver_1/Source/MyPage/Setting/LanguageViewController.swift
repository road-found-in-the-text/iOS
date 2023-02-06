//
//  LanguageViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/02/06.
//

import UIKit

class LanguageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let cellIdentifier = "LanguageCell"
    private let cellContents = ["한국어", "영어"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }
    
    func configureNavigationBar() {
        navigationItem.title = "언어"
    }
    
    func configureTableView() {
        tableView.separatorColor = UIColor(named: "Sub4")
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LanguageTableViewCell else {
            assert(false)
        }
        
        cell.languageLabel.text = cellContents[indexPath.row]
        
        if indexPath.row == 1 {
            cell.languageLabel.textColor = UIColor(named: "Sub2")
            cell.checkImageView.isHidden = true
            cell.temporaryLabel.isHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    
}
