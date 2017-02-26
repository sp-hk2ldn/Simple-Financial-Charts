//
//  SelectStockAndGraphViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit

protocol DidChooseStockDelegate {
    func didChooseStock(ticker: String)
}

class SelectStockAndGraphViewController: UIViewController, DidChooseStockDelegate {
    //MARK:- IBOutlets
    @IBOutlet var companyImageView: UIImageView!
    @IBOutlet var selectStockButtonOutlet: UIButton!
    
    //MARK:- IBAction
    @IBAction func selectStockButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toStockPicker", sender: nil)
    }

    @IBAction func selectMonthlyCloseAPI(_ sender: UIButton) {
        
    }
    
    //MARK:- Variables
    var chosenStockTicker: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- Delegate
    
    func didChooseStock(ticker: String) {
        companyImageView.image = UIImage(named: ticker)
        selectStockButtonOutlet.setTitle(ticker, for: .normal)
        chosenStockTicker = ticker
    }
    
    //MARK:- Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStockPicker" {
            let vc = (segue.destination as! StockPickerViewController)
            vc.didPickStockDelegate = self
        }
    }
}
