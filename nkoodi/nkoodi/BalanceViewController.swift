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
    static let ID = "BalanceViewController"
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var arr = [ChartDataEntry]()
        let yy: Double = 10
        var minus = true
        for i in 0..<10{
            let y: Double
            if minus { y = yy - Double(i) } else { y = yy + Double(i) }
            arr.append(ChartDataEntry(x: Double(i), y: y))
            minus = !minus
        }
        
        let lineChart = LineChartDataSet(values: arr, label: nil)
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
    
    static func create() -> BalanceViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:
            BalanceViewController.ID) as! BalanceViewController
    }
    
    
}

extension BalanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
