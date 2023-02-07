//
//  PostViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/18.
//

import UIKit

class PostViewController: UIViewController {
    
    let maxImageTopHeight: CGFloat = 300
    let minImageTopHeight: CGFloat = 80
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var topImage: UIView!
    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextField.delegate = self
        
        initPostTableView()
        registerXib()
        
        //초기 버튼 테두리 설정
        commentButton.layer.borderWidth = 1
        commentButton.layer.cornerRadius = 17
        commentButton.layer.borderColor = UIColor(named: "Sub2")?.cgColor
        
        self.title = "Forum"
        navigationController?.navigationBar.topItem?.title = ""         //back 버튼 title 없애기
        self.navigationController?.navigationBar.tintColor = .black     //navigationbar item 색깔 변경
        
        //navigationBar 투명해지기
        navigationController?.navigationBar.standardAppearance.backgroundColor = .clear
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .clear
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_more"), style: .plain, target: self, action: #selector(reportTapped))     //네이게이션바 오른쪽 버튼 생성
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.standardAppearance.backgroundColor = .white
        navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .white
    }
    
    // MARK: - Cell 설정
    
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
    
    // MARK: - 버튼 클릭 시
    
    //신고하기 버튼 클릭
    @objc func reportTapped() {
        let reportStoryboard = UIStoryboard(name: Const.Storyboard.Name.report, bundle: nil)
        guard let reportVC = reportStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.report) as? ReportViewController else { return }
        present(reportVC, animated: true)
    }
    
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        guard let commentText = commentTextField.text else { return }
        let task = PostCommentDataModel(comment: commentText)
        postCommentData.append(task)
        postTableView.reloadData()
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: postCommentData.count - 1, section: 4)
            self.postTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }       //댓글 추가시 tableView bottom으로 이동
    }
}

// MARK: - post tableView 및 scrollView 설정

extension PostViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    //tableView 초기 설정
    func initPostTableView() {
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.contentInset = .init(top: 270, left: 0, bottom: 0, right: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return postCommentData.count
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
            guard let postCommentsCell = tableView.dequeueReusableCell(withIdentifier: "PostCommentsTableViewCell", for: indexPath) as? PostCommentsTableViewCell else { return UITableViewCell() }
            let postCommentDataModel = postCommentData[indexPath.row]
            postCommentsCell.commentText.text = postCommentDataModel.comment
            return postCommentsCell
        default:
            return UITableViewCell()
            
        }
    }
    
    //스크롤 시 실행(스크롤 한 만큼 imageView 투명해지게 하기)
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = -scrollView.contentOffset.y
        let ratio = y / (maxImageTopHeight - minImageTopHeight)
        
        topImage.alpha = ratio - 0.3
    }
}

// MARK: - textField 설정

//textField 글자 수 감지해서 버튼 활성화
extension PostViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.location == 0 && range.length != 0 {
            commentButton.layer.borderWidth = 1
            commentButton.layer.cornerRadius = 17
            commentButton.layer.borderColor = UIColor(named: "Sub2")?.cgColor
            self.commentButton.isEnabled = false
        } else {
            commentButton.layer.borderWidth = 1
            commentButton.layer.cornerRadius = 17
            commentButton.layer.borderColor = UIColor.tintColor.cgColor
            self.commentButton.isEnabled = true
        }
        return true
    }
}
