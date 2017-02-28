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
import ChameleonFramework

class HomeScreenViewController: UIViewController, UITextFieldDelegate, ChartViewDelegate, DidChooseStockDelegate, DidChooseChartTypeDelegate {
    //MARK:- IBOutlets
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var chartView: LineChartView!
    @IBOutlet var stockNameLabel: UILabel!
    @IBOutlet var selectChartTypeButton: UIButton!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var hideChartView: UIView!
    //MARK:- IBActions
    @IBAction func searchButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toStockPicker", sender: nil)
    }
    
    
    //MARK:- Variables
    var displayName: String = ""
    var chosenStockTicker: String = ""
    var retrievedStockData: StockPrice! {
        didSet {
            if !self.selectChartTypeButton.isEnabled {
                self.selectChartTypeButton.isEnabled = true
            }
            UIView.animate(withDuration: 0.8) {
                self.selectChartTypeButton.alpha = 1.0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    
    fileprivate func configureUIWithStockData(stockInfo: StockPrice, chartType: ChartType, interval: Int?) {
        
        var dates: [String] = []
        var dataPoints: [Double] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for i in (0 ..< stockInfo.dates.count).reversed()	 {
            if interval != nil {
                if i % interval! != 0 {
                    continue
                }
            }
            dates.append(dateFormatter.string(from: stockInfo.dates[i]))
            switch chartType {
            case .lowPrice:
                dataPoints.append(stockInfo.lowPrice[i])
            case .highPrice:
                dataPoints.append(stockInfo.highPrice[i])
            case .closePrice:
                dataPoints.append(stockInfo.closePrice[i])
            case .openPrice:
                dataPoints.append(stockInfo.openPrices[i])
            case .tradingVolume:
                dataPoints.append(Double(stockInfo.tradingVolume[i]))
            case .exDividend:
                dataPoints.append(stockInfo.exDividend[i])
            case .splitRatio:
                dataPoints.append(Double(stockInfo.splitRatio[i]))
            case .adjClose:
                dataPoints.append(stockInfo.adjClose[i])
            case .adjVolume:
                dataPoints.append(Double(stockInfo.adjVolume[i]))
            case .adjHigh:
                dataPoints.append(stockInfo.adjHigh[i])
            case .adjLow:
                dataPoints.append(stockInfo.adjLow[i])
            case .adjOpen:
                dataPoints.append(stockInfo.adjOpen[i])
            }
            
        }
        setChart(dates: dates, data: dataPoints, chartTitle: chartType.description)
        
    }

    fileprivate func configureUI() {
        chartView.delegate = self
        userNameLabel.text = "\(displayName)'s chart viewer"
        stockNameLabel.text = ""
    }
    
    //MARK:- Textfield Delegates
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        chosenStockTicker = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK:- Did Choose Stock Delegate
    func didChooseStock(ticker: String) {
        if chosenStockTicker == ticker { return } //stop unnecessary API calls
        chosenStockTicker = ticker
        stockNameLabel.text = ticker
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        QuandlServiceDirectory.makeRequest(api: .getAllStockPriceHistory(ticker: ticker), queue: nil, returnType: StockPrice.self) { (result) in
            self.activityIndicator.stopAnimating()
            self.loadingView.isHidden = true
            self.retrievedStockData = result
            self.configureUIWithStockData(stockInfo: self.retrievedStockData, chartType: .closePrice, interval: nil)
            self.stockNameLabel.text = result.name
        }
    }
    
    //MARK:- Did Choose Chart Type Delegate
    func userSelectedChartType(chartType: ChartType) {
        configureUIWithStockData(stockInfo: self.retrievedStockData, chartType: chartType, interval: nil)
    }
    
    //MARK:- ChartView
    
    func setChart(dates: [String], data: [Double], chartTitle:String) {
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dates)
        chartView.xAxis.granularity = 1
        var yValues: [ChartDataEntry] = []
        for i in 0 ..< data.count {
            yValues.append(ChartDataEntry(x: Double(i), y: data[i]))
        }
        let data = LineChartData()
        let yDataSet = LineChartDataSet(values: yValues, label: chartTitle)
        data.addDataSet(yDataSet)
        yDataSet.drawCirclesEnabled = false
        yDataSet.mode = .horizontalBezier
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.wordWrapEnabled = false
        chartView.xAxis.labelRotationAngle = -90
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.chartDescription?.text = chartTitle
        
        
        
        self.chartView.data = data
        if !self.hideChartView.isHidden {
            self.hideChartView.isHidden = true
        }
        self.chartView.animate(yAxisDuration: 1.0)
        
    }
    
    //MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStockPicker" {
            (segue.destination as! StockPickerViewController).didPickStockDelegate = self
        }
        if segue.identifier == "toChartTypeSelector" {
            (segue.destination as! ChartTypeSelectorViewController).didChooseChartDelegate = self
        }
    }
}
