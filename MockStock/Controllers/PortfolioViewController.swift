//
//  ViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 2/1/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    var headerLabel: UILabel = {
        let l = UILabel()
        l.text = "Portfolio"
        return l
    }()
    var networth: UILabel = {
        let l = UILabel()
        l.text = "Net Worth:"
        return l
    }()
    var networthValue: UILabel = {
        let l = UILabel()
        l.text = "9001"
        return l
    }()
    var buyingPower: UILabel = {
        let l = UILabel()
        l.text = "Buying Power:"
        return l
    }()
    var buyingpowerValue: UILabel = {
        let l = UILabel()
        l.text = "9001"
        return l
    }()
    var portfolio: UILabel = {
        let l = UILabel()
        l.text = "Portfolio Value:"
        return l
    }()
    var portfolioValue: UILabel = {
        let l = UILabel()
        l.text = "9001"
        return l
    }()
    var divider: UIView = {
        let v = UIView()
        return v
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        
        // Test label -- Remove it later
        let labelView = UILabel()
        labelView.text = "Portfolio View! (Remove this label later)."
        labelView.textColor = UIColor.black
        labelView.frame = CGRect(x: 25, y: 100, width: 500, height: 25)
        view.addSubview(labelView)
        // End test label
        
    }


}

