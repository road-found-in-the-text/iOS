//
//  ScriptRecordChartCollectionViewCell.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/17.
//

import UIKit

import Charts

class ScriptRecordChartCollectionViewCell: UICollectionViewCell {
    @IBOutlet var resultChart: RadarChartView!
    
    private let resultChartLabels = ["분석력", "논리력", "창의력", "전달력", "전문성"]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureResultChart()
    }
    
    func configureResultChart() {
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
        dataSet.label = "최근 연습"
        
        let previousDataSet = RadarChartDataSet(
            entries: [
                RadarChartDataEntry(value: 3.0),
                RadarChartDataEntry(value: 3.0),
                RadarChartDataEntry(value: 3.0),
                RadarChartDataEntry(value: 4.0),
                RadarChartDataEntry(value: 5.0),
            ]
        )
        
        previousDataSet.colors = [UIColor(named: "Sub1")!]
        previousDataSet.lineWidth = 2
        previousDataSet.drawValuesEnabled = false
        previousDataSet.label = "이전 연습"
        
        // Style
        resultChart.layer.cornerRadius = 6
        resultChart.layer.masksToBounds = true
        
        resultChart.legend.enabled = true
        resultChart.legend.horizontalAlignment = .center
        resultChart.legend.drawInside = true
        resultChart.legend.yOffset = 10
        resultChart.legend.formSize = 13
        resultChart.legend.textColor = UIColor(named: "Sub1") ?? UIColor()
        resultChart.legend.font = .systemFont(ofSize: 13)
        
        resultChart.setExtraOffsets(left: 50, top: 50, right: 50, bottom: 80)
        resultChart.isUserInteractionEnabled = false
        
        resultChart.backgroundColor = .white
        resultChart.webLineWidth = 0
        resultChart.innerWebColor = UIColor(named: "Sub3") ?? UIColor()
        
        
        let xAxis = resultChart.xAxis
        xAxis.labelFont = .boldSystemFont(ofSize: 14)
        xAxis.labelTextColor = UIColor(named: "Sub1") ?? UIColor()
        xAxis.valueFormatter = IndexAxisValueFormatter(values: resultChartLabels)
        
        let yAxis = resultChart.yAxis
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 4
        yAxis.drawLabelsEnabled = false
        
//        let data = RadarChartData()
//        data.dataSets = []
//        
//        resultChart.data = data
    }
}
