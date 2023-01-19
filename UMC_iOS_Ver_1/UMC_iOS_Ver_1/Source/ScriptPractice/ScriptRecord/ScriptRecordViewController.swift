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
    
    private let headerIdentifier = "reusableView"
    private let cellIdentifier = ["resultCell", "chartCell", "memoCell"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ScriptRecordViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section != 2 ? 1 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[indexPath.section], for: indexPath) as? ScriptRecordResultCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[indexPath.section], for: indexPath) as? ScriptRecordChartCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let dataSet = RadarChartDataSet(
                entries: [
                    RadarChartDataEntry(value: 4.0),
                    RadarChartDataEntry(value: 3.0),
                    RadarChartDataEntry(value: 4.0),
                    RadarChartDataEntry(value: 5.0),
                    RadarChartDataEntry(value: 3.0),
                ]
            )
            
            dataSet.colors = [.systemBlue]
            dataSet.lineWidth = 2
            dataSet.drawValuesEnabled = false
            
            cell.resultChart.data?.append(dataSet)
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[indexPath.section], for: indexPath) as? ScriptRecordMemoCollectionViewCell else {
                return UICollectionViewCell()
            }
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
