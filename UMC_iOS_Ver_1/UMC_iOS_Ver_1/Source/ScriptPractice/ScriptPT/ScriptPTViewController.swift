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
        label.textColor = UIColor(named: "Sub1")
        
        return label
    }()
    
    var script: Script?
    
    private var cellSize = CGSize()
    private var minimumItemSpacing: CGFloat = 20
    private let cellIdentifier = "scriptPTcell"
    
    private var timer: Timer?
    var practiceTime = 0
    var elapsedTime = 0
    private var isPaused = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = script?.title

        configureNavigationItem()
        configureCollectionView()
        styleButton()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
    }
    
    // MARK: - Style
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
    
    func pushNextViewController() {
        let storyboard = UIStoryboard(name: "ScriptPracticeRecord", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ScriptPracticeRecordViewController") as? ScriptPracticeRecordViewController else {
            assert(false)
        }
        
        nextViewController.scriptId = script?.scriptId
        nextViewController.elapsedTime = elapsedTime
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
}

// MARK: - Timer
extension ScriptPTViewController {
    func startTimer() {
        if timer != nil && timer!.isValid {
            timer!.invalidate()
        }
                
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)

    }
    
    @objc func timerCallback() {
        setLeftTimeLabel()
        setRightTimeLabel()
        
        if(practiceTime == 0) {
            timer?.invalidate()
            timer = nil
            pushNextViewController()
        }
        
        practiceTime -= 1
        elapsedTime += 1
    }
    
    func setLeftTimeLabel() {
        let remainingMinute = practiceTime / 60
        if remainingMinute > 0 {
            self.leftTimeLabel.text = "\(remainingMinute)분 남았어요."
        } else {
            self.leftTimeLabel.text = "\(practiceTime)초 남았어요."
            self.leftTimeLabel.textColor = .systemRed
        }
        self.leftTimeLabel.sizeToFit()
    }
    
    func setRightTimeLabel() {
        let minute = String(elapsedTime / 60).addZero
        let second = String(elapsedTime % 60).addZero
        
        self.rightTimeLabel.text = "\(minute):\(second)"
        self.rightTimeLabel.sizeToFit()
    }
    
// MARK: - IBAction
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
        pushNextViewController()
    }
}

// MARK: - UICollectionView
extension ScriptPTViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return script?.paragraphList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ScriptPTCollectionViewCell else {
            assert(false)
        }
        
        guard let paragraph = script?.paragraphList[indexPath.row] else {
            assert(false)
        }
        
        let paragraphNumber = String(indexPath.row + 1)
        
        cell.titleLabel.text = "\(paragraphNumber.addZero) \(paragraph.title)"
        cell.contentLabel.text = paragraph.contents
        
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
