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
    //섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //섹션 제목
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "🔥 Best Forum"
        } else {
            return "Forum"
        }
    }
    
    //섹션 안의 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    //셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
<<<<<<< HEAD
<<<<<<< HEAD
        switch indexPath.section {
        case 0:
            guard let bestForumcell = tableView.dequeueReusableCell(withIdentifier: "BestForumTableViewCell", for: indexPath) as? BestForumTableViewCell else { return UITableViewCell() }
            bestForumcell.cellDelegate = self
=======
        switch indexPath.section{
        case 0:
            guard let bestForumcell = tableView.dequeueReusableCell(withIdentifier: "BestForumTableViewCell", for: indexPath) as? BestForumTableViewCell else { return UITableViewCell() }
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
=======
        switch indexPath.section{
        case 0:
            guard let bestForumcell = tableView.dequeueReusableCell(withIdentifier: "BestForumTableViewCell", for: indexPath) as? BestForumTableViewCell else { return UITableViewCell() }
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
            return bestForumcell
        case 1:
            guard let forumCell = tableView.dequeueReusableCell(withIdentifier: "ForumTableViewCell", for: indexPath) as? ForumTableViewCell else { return UITableViewCell() }
            return forumCell
        default:
            return UITableViewCell()
        }
    }
    
    //셀 높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 175
        } else {
            return 112
        }
    }
    
    //셀 선택 시 화면이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postStoryboard = UIStoryboard(name: Const.Storyboard.Name.post, bundle: nil)
        guard let postVC = postStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.post) as? PostViewController else { return }
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
<<<<<<< HEAD
<<<<<<< HEAD

extension HomeViewController: CollectionViewCellDelegate {
    func collectionView(collectionViewCell: BestForumCollectionViewCell?, index: Int, didTappedInTableViewCell: BestForumTableViewCell) {
        let postStoryboard = UIStoryboard(name: Const.Storyboard.Name.post, bundle: nil)
        guard let postVC = postStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.post) as? PostViewController else { return }
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
=======
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
=======
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
