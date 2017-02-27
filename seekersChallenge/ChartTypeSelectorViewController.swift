//
//  ChartTypeSelectorViewController.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 28/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import UIKit
import ChameleonFramework

enum ChartType: Int, CustomStringConvertible {
    case openPrice,
    highPrice,
    lowPrice,
    closePrice,
    tradingVolume,
    exDividend,
    splitRatio,
    adjOpen,
    adjHigh,
    adjLow,
    adjClose,
    adjVolume
    
    var description: String {
        switch self {
        case .openPrice: return "Open Price"
        case .highPrice: return "High Price"
        case .lowPrice: return "Low Price"
        case .closePrice: return "Close Price"
        case .tradingVolume: return "Trading Volume"
        case .exDividend: return "Ex Dividend"
        case .splitRatio: return "Split Ratio"
        case .adjOpen: return "Adjusted Open Price"
        case .adjLow: return "Adjusted Low Price"
        case .adjHigh: return "Adjusted High Price"
        case .adjClose: return "Adjusted Close Price"
        case .adjVolume: return "Adjusted Volume"
        }
    }
}


class ChartTypeSelectorViewController: UIViewController {
    //MARK:- IBOutlets
    @IBOutlet var chartTypeSelectorButton: [UIButton]! {
        didSet {
            var i = 0
            for button in chartTypeSelectorButton {
                button.titleLabel?.numberOfLines = 0
                button.titleLabel?.textAlignment = .center
                button.addTarget(self, action: #selector(test(sender:)), for: .touchUpInside)
                button.setTitle(ChartType(rawValue: i)?.description, for: .normal)
                i += 1
                button.layer.cornerRadius = 2.0
            }
        }
    }
    //MARK:- Variables
    var didChooseChartDelegate: DidChooseChartTypeDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func test(sender: UIButton){
        for i in 0 ..< chartTypeSelectorButton.count {
            if sender == chartTypeSelectorButton[i] {
                guard let chartType = ChartType(rawValue: i) else {
                    return
                }
                didChooseChartDelegate?.userSelectedChartType(chartType: chartType)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

}
