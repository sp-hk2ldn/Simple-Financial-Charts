//
//  StockPickerViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit

class StockPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    //MARK:- Outlets
    @IBOutlet var pickerView: UIPickerView!
    
    //MARK:- Actions
    @IBAction func tapOutsidePicker(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
        didPickStockDelegate?.didChooseStock(ticker: pickedSymbol)
    }
    
    
    //MARK:- Variables
    let stockSymbols = ["AAPL", "FB", "GOOGL"]
    var didPickStockDelegate: DidChooseStockDelegate?
    var pickedSymbol: String = "AAPL"

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK:- PickerView
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stockSymbols.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont.init(name: "Avenir", size: 22)
        pickerLabel.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        pickerLabel.textAlignment = .center
        pickerLabel.text = stockSymbols[row]
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickedSymbol = stockSymbols[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

}
