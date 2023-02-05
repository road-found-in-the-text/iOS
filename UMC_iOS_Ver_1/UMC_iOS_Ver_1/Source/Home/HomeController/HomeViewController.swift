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
        
        navigationBarTitle()
        registerXib()
        forumTableView.delegate = self
        forumTableView.dataSource = self
        if #available(iOS 15, *) {
            forumTableView.sectionHeaderTopPadding = 0
        }
    }
    
    func navigationBarTitle() {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.text = "글길"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
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
    
    //custom section header 만들기
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let label = UILabel()
        if section == 0 { label.text = "🔥 BEST Forum" } else { label.text = "Forum" }
        label.font = .boldSystemFont(ofSize: 23)
        label.frame = CGRect(x: 20, y: 20, width: 250, height: 20)
        view.addSubview(label)
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let view = UIView()
            view.backgroundColor = UIColor(named: "Sub4")
            return view
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
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
        switch indexPath.section {
        case 0:
            guard let bestForumcell = tableView.dequeueReusableCell(withIdentifier: "BestForumTableViewCell", for: indexPath) as? BestForumTableViewCell else { return UITableViewCell() }
            bestForumcell.cellDelegate = self
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
            return 180
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

extension HomeViewController: CollectionViewCellDelegate {
    //collectionView Cell 선택 시 post 화면으로 이동
    func collectionView(collectionViewCell: BestForumCollectionViewCell?, index: Int, didTappedInTableViewCell: BestForumTableViewCell) {
        let postStoryboard = UIStoryboard(name: Const.Storyboard.Name.post, bundle: nil)
        guard let postVC = postStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.post) as? PostViewController else { return }
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
