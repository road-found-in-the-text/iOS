//
//  BestForumTableViewCell.swift
//  project
//
//  Created by 왕정빈 on 2023/01/06.
//

import UIKit

<<<<<<< HEAD
protocol CollectionViewCellDelegate: AnyObject {
    func collectionView(collectionViewCell: BestForumCollectionViewCell?, index: Int, didTappedInTableViewCell: BestForumTableViewCell)
}

=======
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
class BestForumTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
<<<<<<< HEAD
    weak var cellDelegate: CollectionViewCellDelegate?
=======
    
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerXib()
        registerDelegate()
        collectionViewFlowLayout()
    }
    
    //collectionView 레이아웃
    private func collectionViewFlowLayout() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 185, height: 175)
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

<<<<<<< HEAD
extension BestForumTableViewCell: UICollectionViewDataSource {
=======
extension BestForumTableViewCell: UICollectionViewDataSource{
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BestForumDataModel.bestForumData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestForumCollectionViewCell", for: indexPath) as? BestForumCollectionViewCell else { return UICollectionViewCell() }
        return collectionViewCell
    }
<<<<<<< HEAD
    
    //collectionView item 선택 시 화면 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? BestForumCollectionViewCell
        self.cellDelegate?.collectionView(collectionViewCell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
=======
>>>>>>> parent of a7db6f8 (init: 초기 업로드)
}
