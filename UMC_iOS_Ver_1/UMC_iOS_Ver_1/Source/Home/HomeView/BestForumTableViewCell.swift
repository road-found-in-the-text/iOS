//
//  BestForumTableViewCell.swift
//  project
//
//  Created by 왕정빈 on 2023/01/06.
//

import UIKit
import Alamofire
import Kingfisher

//tableViewCell 안에 있는 collectionViewCell 클릭하기 위한 delegate
protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionViewCell: BestForumCollectionViewCell?, index: Int, didTappedInTableViewCell: BestForumTableViewCell)
}

class BestForumTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    let netWorkingData = NetWorkingData.shared
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        getBestForumData()
        
        collectionView.contentInset = .init(top: 0, left: 15, bottom: 0, right: 0)  //collectionview cell 처음 왼쪽 여백 주기
        
        registerXib()
        registerDelegate()
        collectionViewFlowLayout()
    }
    
    //collectionView 레이아웃
    private func collectionViewFlowLayout() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 150, height: 153)
        collectionView.collectionViewLayout = flowLayout
        flowLayout.scrollDirection = .horizontal
    }
    
    //collectionViewCell 등록
    private func registerXib(){
        let bestForumNib = UINib(nibName: "BestForumCollectionViewCell", bundle: nil)
        collectionView.register(bestForumNib, forCellWithReuseIdentifier: "BestForumCollectionViewCell")
    }
    
    private func registerDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension BestForumTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestForumData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestForumCollectionViewCell", for: indexPath) as? BestForumCollectionViewCell else { return UICollectionViewCell() }
        
        let bestForumData = bestForumData[indexPath.row]
        collectionViewCell.bestForumTitleLabel.text = bestForumData.title
        collectionViewCell.numOfBestForumLikesLabel.text = "\(bestForumData.likeNum)"
        collectionViewCell.numOfBestForumPhotosLabel.text = "\(bestForumData.imageVideoNum)"
        collectionViewCell.numOfBestForumCommentsLabel.text = "\(bestForumData.commentNum)"
        collectionViewCell.bestForumImage.kf.setImage(with: URL(string: bestForumData.forumImageURL![0]))

        
        return collectionViewCell
    }
    
    //collectionView item 선택 시 화면 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bestForumData = bestForumData[indexPath.row]
        netWorkingData.forumID = bestForumData.forumID
        
        let cell = collectionView.cellForItem(at: indexPath) as? BestForumCollectionViewCell
        self.cellDelegate?.collectionView(collectionViewCell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
}


extension BestForumTableViewCell {
    func getBestForumData() {
        let url = "https://api.road-found-in-the-text-server.com/forum/bestforum"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BestForumDataModel.self) { response in
                switch response.result {
                case .success(let data):
                    bestForumData = data.data
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
