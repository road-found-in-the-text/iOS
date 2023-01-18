//
//  ScriptPTViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/18.
//

import UIKit

class ScriptPTViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    private let cellSize = CGSize(width: 302, height: 140)
    private var minimumItemSpacing: CGFloat = 20
    private let cellIdentifier = "scriptPTcell"

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        styleButton()
    }
    
    func configureCollectionView() {
        let cellWidth: CGFloat = floor(cellSize.width)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
    
    func styleButton() {
        pauseButton.layer.cornerRadius = 8
        stopButton.layer.cornerRadius = 8
    }

}

// MARK: - UICollectionView
extension ScriptPTViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ScriptPTCollectionViewCell else {
            assert(false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
    // MARK: Paging Effect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludeSpacing = cellSize.width + minimumItemSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex: CGFloat = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumItemSpacing
    }
    
}
