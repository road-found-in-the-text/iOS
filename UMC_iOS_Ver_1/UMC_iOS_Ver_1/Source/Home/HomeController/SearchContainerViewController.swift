//
//  SearchContainerViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/13.
//

import UIKit
import Alamofire

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

// MARK: - tableView 설정

extension SearchContainerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forumData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForumTableViewCell", for: indexPath) as? ForumTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        let forumData = forumData[indexPath.row]
        let uploadTime = HomeViewController.toDate(uploadTime: forumData.createDate)
        cell.forumTitleLabel.text = forumData.title
        cell.numOfForumLikesLabel.text = "\(forumData.likeNum)"
        cell.numOfForumPhotosLabel.text = "\(forumData.imageVideoNum)"
        cell.numOfForumCommentsLabel.text = "\(forumData.commentNum)"
        cell.forumNickNameAndUploadTime.text = "\(forumData.writer) · \(HomeViewController.timeInterval(uploadTime: uploadTime!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    //셀 선택 시 화면이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postStoryboard = UIStoryboard(name: Const.Storyboard.Name.post, bundle: nil)
        guard let postVC = postStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.post) as? PostViewController else { return }
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}
