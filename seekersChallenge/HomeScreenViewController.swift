//
//  HomeScreenViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit
import SwiftyJSON
import Charts

class HomeScreenViewController: UIViewController, UITextFieldDelegate, ChartViewDelegate {
    //MARK:- IBOutlets
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var stockSearchTextField: UITextField!
    @IBOutlet var chartView: LineChartView!
    //MARK:- IBActions
    @IBAction func searchButton(_ sender: UIButton) {
        QuandlServiceDirectory.makeRequest(api: .getMonthlyClosingPriceForYear(ticker: "FB", startDate: "2016-02-01", endDate: "2017-01-01"), queue: nil) { (json) in
            let monthlyClose = MonthlyClose(jsonData: json)
            self.configureUIWithStockData(monthlyClose: monthlyClose)
        }
    }
    
    
    //MARK:- Variables
    var displayName: String = ""
    var chosenStock: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func configureUIWithStockData(monthlyClose: MonthlyClose) {
        var months: [String] = []
        var prices: [Double] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for dataPoint in monthlyClose.dataPointsArray {
            months.append(dateFormatter.string(from: dataPoint.0))
            prices.append(Double(dataPoint.1))
        }
        setChart(months: months, prices: prices)
    }

    fileprivate func configureUI() {
        chartView.delegate = self
        userNameLabel.text = displayName
    }
    
    //MARK:- Textfield Delegates
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        chosenStock = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK:- ChartView
    

    
    func setChart(months: [String], prices: [Double]) {
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        chartView.xAxis.granularity = 1
        
        var yValues: [ChartDataEntry] = []
        
        for i in 0 ..< months.count {
            yValues.append(ChartDataEntry(x: Double(i), y: prices[i]))
        }
        let data = LineChartData()
        let yDataSet = LineChartDataSet(values: yValues, label: "Month on Month Close Price")
        data.addDataSet(yDataSet)
        self.chartView.data = data
        self.chartView.animate(yAxisDuration: 1.0)
        
        
    }
}
