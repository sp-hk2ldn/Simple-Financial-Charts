//
//  HomeScreenViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITextFieldDelegate {
    //MARK:- IBOutlets
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var stockSearchTextField: UITextField!
    //MARK:- IBActions
    @IBAction func searchButton(_ sender: UIButton) {
        YahooServiceDirectory.makeRequest(api: .getStockInformation, queue: nil) { (response) in
            print(response)
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

    fileprivate func configureUI(){
        userNameLabel.text = displayName
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        chosenStock = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
