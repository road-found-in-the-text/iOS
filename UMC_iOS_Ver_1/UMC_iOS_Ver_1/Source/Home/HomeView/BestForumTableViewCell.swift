//
//  BestForumTableViewCell.swift
//  project
//
//  Created by 왕정빈 on 2023/01/06.
//

import UIKit

class BestForumTableViewCell: UITableViewCell, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
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

extension BestForumTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BestForumDataModel.bestForumData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestForumCollectionViewCell", for: indexPath) as? BestForumCollectionViewCell else { return UICollectionViewCell() }
        return collectionViewCell
    }
}
