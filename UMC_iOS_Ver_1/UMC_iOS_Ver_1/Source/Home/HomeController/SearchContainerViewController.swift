//
//  SearchContainerViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/13.
//

import UIKit

class SearchContainerViewController: UIViewController {

    @IBOutlet weak var contentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXib()
        contentsTableView.delegate = self
        contentsTableView.dataSource = self
    }
    
    //검색 후 forumTableViewCell Xib 등록
    private func registerXib() {
        let forumCell = UINib(nibName: "ForumTableViewCell", bundle: nil)
        contentsTableView.register(forumCell, forCellReuseIdentifier: "ForumTableViewCell")
    }
}

extension SearchContainerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForumTableViewCell", for: indexPath) as? ForumTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
}
