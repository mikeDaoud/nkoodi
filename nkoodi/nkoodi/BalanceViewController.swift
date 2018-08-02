//
//  BalanceViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import Charts

class BalanceViewController: BaseViewController {
    static let ID = "BalanceViewController"
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var historyTable: UITableView!
    
    //vars
    var transactionsHistory: (ascTransactionsHistory: TransactionsHistory, desTransactionsHistory: TransactionsHistory)? {
        didSet {
            lblBalance.text = "\(transactionsHistory?.ascTransactionsHistory.currentBalance ?? 0) ASR"
        }
    }
    
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
        
        historyTable.register(UINib(nibName: "TransactionHistroyCell", bundle: nil), forCellReuseIdentifier: "TransactionHistroyCell")
        historyTable.rowHeight = UITableViewAutomaticDimension
        historyTable.estimatedRowHeight = 100
        historyTable.allowsSelection = false
        
        let data = LineChartData(dataSet: lineChart)
        chartView.data = data
        chartView.chartDescription?.text = nil
        DataStore.shared.getTransactionsHistory(completion: { transactionsHistory in
            self.transactionsHistory = transactionsHistory
            self.reloadView()
        })
    }
    
    static func create() -> BalanceViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:
            BalanceViewController.ID) as! BalanceViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadView()
    }
    
    func reloadView() {
//        CATransaction.begin()
//        CATransaction.setCompletionBlock({
//
//        })
        historyTable.reloadData()
//        CATransaction.commit()
    }
}

extension BalanceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsHistory?.desTransactionsHistory.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionHistroyCell", for: indexPath) as! TransactionHistroyCell
        cell.configure(transaction: (transactionsHistory?.desTransactionsHistory.transactions ?? [])[indexPath.row])
        return cell
    }

}
