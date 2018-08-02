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
            var accumlatedBalance: Double = 0
            var counter: Double = 0
            for trans in transactionsHistory!.desTransactionsHistory.transactions {
                accumlatedBalance += trans.amountChanged
                chartDataEntryArr.append(ChartDataEntry(x: counter, y: accumlatedBalance))
                counter += 1
            }
        }
    }
    
    var chartDataEntryArr: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTable.register(UINib(nibName: "TransactionHistroyCell", bundle: nil), forCellReuseIdentifier: "TransactionHistroyCell")
        historyTable.rowHeight = UITableViewAutomaticDimension
        historyTable.estimatedRowHeight = 100
        historyTable.allowsSelection = false

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
        historyTable.reloadData()
        
        let lineChart = LineChartDataSet(values: chartDataEntryArr, label: nil)
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
