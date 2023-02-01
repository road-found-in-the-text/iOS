//
//  ScriptPracticeViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/18.
//

import UIKit

class ScriptPracticeSetViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var collectionView: UICollectionView!
    
    private var cellSize = CGSize()
    private var minimumItemSpacing: CGFloat = 20
    private let cellIdentifier = "scriptPTcell"
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presentModal()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dismiss(animated: false)
    }
    
    func configureCollectionView() {
        cellSize = CGSize(width: collectionView.frame.width - 37 * 2, height: collectionView.frame.height * 0.9)
        let cellWidth: CGFloat = floor(cellSize.width)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
    
    private func presentModal() {
        guard let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ScriptBottomSheetViewController") as? ScriptBottomSheetViewController else {
            return
        }
        detailViewController.delegate = self
        
        let nav = UINavigationController(rootViewController: detailViewController)
        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [
                .custom { _ in
                    return 286
                },
                .medium()
            ]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        present(nav, animated: true, completion: nil)
        
    }


}

extension ScriptPracticeSetViewController: ScriptBottomSheetDelegate {
    func practiceStartButtonTapped() {
        self.dismiss(animated: true)
        
        let storyboard = UIStoryboard(name: "ScriptPT", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ScriptPTViewController") as? ScriptPTViewController else {
            assert(false)
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - UICollectionView
extension ScriptPracticeSetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: collectionView.frame.width - 37 * 2, height: collectionView.frame.height * 0.9)
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
