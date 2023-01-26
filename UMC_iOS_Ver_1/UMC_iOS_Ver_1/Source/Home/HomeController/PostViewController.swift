//
//  PostViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/18.
//

import UIKit

class PostViewController: UIViewController {
    
    let maxImageTopHeight: CGFloat = 300
    let minImageTopHeight: CGFloat = 47
    
    @IBOutlet weak var representativeImage: UIView!
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPostTableView()
        transparentNavigationBar()
        registerXib()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(reportTapped))     //네이게이션바 오른쪽 버튼 생성
    }
    
    //custom cell 등록
    func registerXib() {
        let userProfileCell = UINib(nibName: "UserProfileTableViewCell", bundle: nil)
        postTableView.register(userProfileCell, forCellReuseIdentifier: "UserProfileTableViewCell")
        let postContentCell = UINib(nibName: "PostContentTableViewCell", bundle: nil)
        postTableView.register(postContentCell, forCellReuseIdentifier: "PostContentTableViewCell")
        let numOfLikesCell = UINib(nibName: "NumofLikesTableViewCell", bundle: nil)
        postTableView.register(numOfLikesCell, forCellReuseIdentifier: "NumofLikesTableViewCell")
        let numOfCommentsCell = UINib(nibName: "NumOfCommentsTableViewCell", bundle: nil)
        postTableView.register(numOfCommentsCell, forCellReuseIdentifier: "NumOfCommentsTableViewCell")
        let postCommetnsCell = UINib(nibName: "PostCommentsTableViewCell", bundle: nil)
        postTableView.register(postCommetnsCell, forCellReuseIdentifier: "PostCommentsTableViewCell")
    }
    
    //navigationBar 투명하게 하기
    func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    //tableView 초기 설정
    func initPostTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.contentInset = .init(top: 321, left: 0, bottom: 0, right: 0)
    }
    
    //신고하기 버튼 클릭
    @objc func reportTapped() {
        let reportStoryboard = UIStoryboard(name: Const.Storyboard.Name.report, bundle: nil)
        guard let reportVC = reportStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.report) as? ReportViewController else { return }
        present(reportVC, animated: true)
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let userProfileCell = tableView.dequeueReusableCell(withIdentifier: "UserProfileTableViewCell", for: indexPath) as? UserProfileTableViewCell else { return UITableViewCell() }
            return userProfileCell
        case 1:
            guard let postContentCell = tableView.dequeueReusableCell(withIdentifier: "PostContentTableViewCell", for: indexPath) as? PostContentTableViewCell else { return UITableViewCell() }
            return postContentCell
        case 2:
            guard let numOfLikesCell = tableView.dequeueReusableCell(withIdentifier: "NumofLikesTableViewCell", for: indexPath) as? NumofLikesTableViewCell else { return UITableViewCell() }
            return numOfLikesCell
        case 3:
            guard let numOfCommentsCell = tableView.dequeueReusableCell(withIdentifier: "NumOfCommentsTableViewCell", for: indexPath) as? NumOfCommentsTableViewCell else { return UITableViewCell() }
            return numOfCommentsCell
        case 4:
            guard let postCommetsCell = tableView.dequeueReusableCell(withIdentifier: "PostCommentsTableViewCell", for: indexPath) as? PostCommentsTableViewCell else { return UITableViewCell() }
            return postCommetsCell
        default:
            return UITableViewCell()
            
        }
    }
    
    //스크롤 시 실행(스크롤 한 만큼 imageView 투명해지게 하기)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = -scrollView.contentOffset.y
        let ratio = y / (maxImageTopHeight - minImageTopHeight)
        
        representativeImage.alpha = ratio
    }
}
