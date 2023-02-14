//
//  ViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit
import Alamofire

protocol ForumDataDelegate {
    var url: String { get }
    func getForumData()
}

class HomeViewController: UIViewController {
    
    let netWorkingData = NetWorkingData.shared
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getForumData()
    }
    
    // MARK: - navigationBar 설정
    
    //제목 label에 이미지 붙여넣기
    func navigationBarTitle() {
        let titleLabel = UILabel()
        let originalString = ""
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "title2")
        let attachmentString = NSAttributedString(attachment: attachment)
        let contentString = NSMutableAttributedString(string: originalString)
        contentString.append(attachmentString)
        titleLabel.attributedText = contentString
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
    }
    
    // MARK: - Cell 설정
    
    //커스텀cell 등록
    private func registerXib() {
        let forumCell = UINib(nibName: "ForumTableViewCell", bundle: nil)
        forumTableView.register(forumCell, forCellReuseIdentifier: "ForumTableViewCell")
        let bestForumCell = UINib(nibName: "BestForumTableViewCell", bundle: nil)
        forumTableView.register(bestForumCell, forCellReuseIdentifier: "BestForumTableViewCell")
    }
}

// MARK: - tableView 설정

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
            return forumData.count
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
            
            forumCell.selectionStyle = .none
            
            let forumData = forumData[indexPath.row]
            let uploadTime = HomeViewController.toDate(uploadTime: forumData.createDate)
            forumCell.forumTitleLabel.text = forumData.title
            forumCell.numOfForumLikesLabel.text = "\(forumData.likeNum)"
            forumCell.numOfForumPhotosLabel.text = "\(forumData.imageVideoNum)"
            forumCell.numOfForumCommentsLabel.text = "\(forumData.commentNum)"
            forumCell.forumNickNameAndUploadTime.text = "\(forumData.writer) · \(HomeViewController.timeInterval(uploadTime: uploadTime!))"
            
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
            return 140
        }
    }
    
    //셀 선택 시 화면이동
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postStoryboard = UIStoryboard(name: Const.Storyboard.Name.post, bundle: nil)
        guard let postVC = postStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.post) as? PostViewController else { return }
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}

// MARK: - collectionView Cell 선택 시 행동에 관한 설정

extension HomeViewController: CollectionViewCellDelegate {
    //collectionView Cell 선택 시 post 화면으로 이동
    func collectionView(collectionViewCell: BestForumCollectionViewCell?, index: Int, didTappedInTableViewCell: BestForumTableViewCell) {
        let postStoryboard = UIStoryboard(name: Const.Storyboard.Name.post, bundle: nil)
        guard let postVC = postStoryboard.instantiateViewController(withIdentifier: Const.ViewController.identifier.post) as? PostViewController else { return }
        self.navigationController?.pushViewController(postVC, animated: true)
    }
}

// MARK: - 네트워킹

extension HomeViewController: ForumDataDelegate {
    var url: String {
        return netWorkingData.basicURL + "/forum?page=\(netWorkingData.numOfPage)"
    }
    
    func getForumData() {
        netWorkingData.numOfPage = 1
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ForumDataModel.self) { response in
                switch response.result {
                case .success(let data):
                    forumData.append(contentsOf: data.data)
                    self.netWorkingData.totalPage = data.totalPage
                    self.netWorkingData.numOfPage += 1
                    self.forumTableView.reloadData()
                    if self.netWorkingData.numOfPage <= self.netWorkingData.totalPage {
                        self.getForumData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

// MARK: - 업로드 시간 계산

extension HomeViewController {
    static func timeInterval(uploadTime: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateTimeStyle = .named
        
        let now = Date()
        
        return formatter.localizedString(for: uploadTime, relativeTo: now)
    }
    
    static func toDate(uploadTime: String) -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: uploadTime)
        return date
    }
}
