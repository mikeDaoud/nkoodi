//
//  BalanceViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import Charts

class BalanceViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [ChartDataEntry]()
        var yy: Double = 10
        var minus = true
        for i in 0..<10{
            let y: Double
            if minus { y = yy - Double(i) } else { y = yy + Double(i) }
            arr.append(ChartDataEntry(x: Double(i), y: y))
            minus = !minus
        }
        
        var lineChart = LineChartDataSet(values: arr, label: nil)
        lineChart.colors = [NSUIColor.clear]
        lineChart.fillColor = UIColor.red
        lineChart.mode = .cubicBezier
        lineChart.drawCirclesEnabled = false
        lineChart.drawFilledEnabled = true
        lineChart.lineCapType = .round
        lineChart.formLineWidth = 0
        lineChart.drawValuesEnabled = true
        
        
        let data = LineChartData(dataSet: lineChart)
        chartView.data = data
        chartView.chartDescription?.text = nil
    }
}

