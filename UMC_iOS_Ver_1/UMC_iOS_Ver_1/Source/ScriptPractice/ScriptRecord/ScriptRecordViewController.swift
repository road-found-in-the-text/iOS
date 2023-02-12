//
//  ScriptRecordViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/16.
//

import UIKit

import Charts

class ScriptRecordViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var recordResult = ScriptIdRecordData(resultCount: 0, mean: 0, totalElapsedMinute: 0, totalElapsedSecond: 0, records: [], memoList: [])
    
    private let headerIdentifier = "reusableView"
    private let cellIdentifier = ["resultCell", "chartCell", "memoCell"]

    override func viewDidLoad() {
        super.viewDidLoad()

        ScriptRecordIdDataManager().fetchScriptRecordById(scriptId: 1, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

}

// MARK: - Networking
extension ScriptRecordViewController: ScriptRecordIdDelegate {
    func didFetchScriptRecordById(result: ScriptIdRecordData) {
        recordResult = result
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView
extension ScriptRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section != 2 ? 1 : recordResult.memoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0: // 연습 기록
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[indexPath.section], for: indexPath) as? ScriptRecordResultCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.countLabel.text = "\(recordResult.resultCount)회"
            cell.averageScoreLabel.text = "\(recordResult.mean)/10"
            cell.totalPracticeTimeLabel.text = "\(String(recordResult.totalElapsedMinute).addZero) : \(String(recordResult.totalElapsedSecond).addZero)"
            
            return cell
        case 1: // 연습 완벽도
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[indexPath.section], for: indexPath) as? ScriptRecordChartCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if recordResult.resultCount == 0 {
                return cell
            }
            
            let currentScore = recordResult.records[0]
            
            let dataSet = RadarChartDataSet(
                entries: [
                    RadarChartDataEntry(value: currentScore.score1),
                    RadarChartDataEntry(value: currentScore.score2),
                    RadarChartDataEntry(value: currentScore.score3),
                    RadarChartDataEntry(value: currentScore.score4),
                    RadarChartDataEntry(value: currentScore.score5),
                ]
            )
            
            dataSet.colors = [.systemBlue]
            dataSet.lineWidth = 2
            dataSet.drawValuesEnabled = false
            dataSet.label = "최근 연습"
            
            let data = RadarChartData()
            data.dataSets = [dataSet]
            
            if recordResult.resultCount > 1 {
                let previousScore = recordResult.records[1]
                
                let previousDataSet = RadarChartDataSet(
                    entries: [
                        RadarChartDataEntry(value: previousScore.score1),
                        RadarChartDataEntry(value: previousScore.score2),
                        RadarChartDataEntry(value: previousScore.score3),
                        RadarChartDataEntry(value: previousScore.score4),
                        RadarChartDataEntry(value: previousScore.score5),
                    ]
                )
                
                previousDataSet.colors = [UIColor(named: "Sub1")!]
                previousDataSet.lineWidth = 2
                previousDataSet.drawValuesEnabled = false
                previousDataSet.label = "이전 연습"
                
                data.dataSets.append(previousDataSet)
            }
            
            cell.resultChart.data = data
            
            return cell
        case 2: // 메모
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[indexPath.section], for: indexPath) as? ScriptRecordMemoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let memo = recordResult.memoList[indexPath.row]
            
            cell.numberLabel.text = "\(memo.resultCount)회"
            cell.contentLabel.text = memo.memo
            
            return cell
        default:
            assert(false, "cell을 찾을 수 없습니다.")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        
        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: 81)
        case 1:
            return CGSize(width: width, height: 375)
        case 2:
            return CGSize(width: width, height: 85)
        default:
            return CGSize(width: width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? ScriptRecordCollectionReusableView else {
                assert(false, "header를 찾을 수 없습니다.")
            }
            
            switch indexPath.section {
            case 0:
                header.titleLabel.text = "연습 기록"
                header.subtitleLabel.isHidden = true
            case 1:
                header.titleLabel.text = "연습 완벽도"
                header.subtitleLabel.isHidden = true
            case 2:
                header.titleLabel.text = "메모"
                header.subtitleLabel.text = "완벽한 연습을 위한 한 마디"
                header.subtitleLabel.isHidden = false
            default:
                assert(false)
            }
            
            return header
        default:
            assert(false, "header를 찾을 수 없습니다.")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
}
