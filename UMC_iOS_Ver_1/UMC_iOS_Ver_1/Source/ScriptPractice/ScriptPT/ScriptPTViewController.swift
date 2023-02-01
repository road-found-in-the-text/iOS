//
//  ScriptPTViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/18.
//

import UIKit

class ScriptPTViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    lazy var leftTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "0분 남았어요"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "Sub1")
        
        return label
    }()
    
    lazy var rightTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .boldSystemFont(ofSize: 14)
        
        return label
    }()
    
    private var cellSize = CGSize()
    private var minimumItemSpacing: CGFloat = 20
    private let cellIdentifier = "scriptPTcell"
    
    private var timer: Timer?
    private var timerNumber = 60
    private var time = 0
    private var isPaused = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationItem()
        configureCollectionView()
        styleButton()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    func configureNavigationItem() {
        self.navigationItem.leftItemsSupplementBackButton = true

        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.backButtonTitle = ""
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftTimeLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightTimeLabel)
    }
    
    func configureCollectionView() {
        cellSize = CGSize(width: collectionView.frame.width - 37 * 2, height: collectionView.frame.height)
        let cellWidth: CGFloat = floor(cellSize.width)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
    }
    
    func styleButton() {
        pauseButton.layer.cornerRadius = 8
        stopButton.layer.cornerRadius = 8
    }
    
}

// MARK: - Timer
extension ScriptPTViewController {
    func startTimer() {
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
        
        timerNumber = 10 // 타이머 시간 설정
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)

    }
    
    @objc func timerCallback() {
        self.leftTimeLabel.text = "\(timerNumber)분 남았어요."
        self.rightTimeLabel.text = "00:\(time)"
        
        self.leftTimeLabel.sizeToFit()
        self.rightTimeLabel.sizeToFit()

        print(timerNumber)
        
        if(timerNumber == 0) {
            timer?.invalidate()
            timer = nil
        }
        
        timerNumber -= 1
        time += 1
    }
    
    @IBAction func pressPauseButton(_ sender: UIButton) {
        isPaused.toggle()
        
        if isPaused {
            timer?.invalidate()
            pauseButton.setImage(UIImage(named: "ic_play"), for: .normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            pauseButton.setImage(UIImage(named: "ic_pause"), for: .normal)
        }
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ScriptPracticeRecord", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ScriptPracticeRecordViewController") as? ScriptPracticeRecordViewController else {
            assert(false)
        }
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
        return CGSize(width: collectionView.frame.width - 37 * 2, height: collectionView.frame.height)
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
