//
//  HomeScreenViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 26/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var userNameLabel: UILabel!
    
    
    //MARK:- Variables
    var displayName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }

    fileprivate func configureUI(){
        userNameLabel.text = displayName
    }
}
