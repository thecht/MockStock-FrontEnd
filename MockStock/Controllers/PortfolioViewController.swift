//
//  ViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 2/1/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {

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

