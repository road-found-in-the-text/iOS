//
//  ViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var forumTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        forumTableView.delegate = self
        forumTableView.dataSource = self
    }
    
    //커스텀cell 등록
    private func registerXib() {
        let forumCell = UINib(nibName: "ForumTableViewCell", bundle: nil)
        forumTableView.register(forumCell, forCellReuseIdentifier: "ForumTableViewCell")
        let bestForumCell = UINib(nibName: "BestForumTableViewCell", bundle: nil)
        forumTableView.register(bestForumCell, forCellReuseIdentifier: "BestForumTableViewCell")
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "🔥 Best Forum"
        } else {
            return "Forum"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            guard let bestForumcell = tableView.dequeueReusableCell(withIdentifier: "BestForumTableViewCell", for: indexPath) as? BestForumTableViewCell else { return UITableViewCell() }
            return bestForumcell
        case 1:
            guard let forumCell = tableView.dequeueReusableCell(withIdentifier: "ForumTableViewCell", for: indexPath) as? ForumTableViewCell else { return UITableViewCell() }
            return forumCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 175
        } else {
            return 112
        }
    }
    
}
