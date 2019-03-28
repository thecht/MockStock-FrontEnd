//
//  MarketplaceViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

var viewLabel: UIButton = {
    let b = UIButton()
    b.setTitle("MarketPlace", for: .normal)
    b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
    b.setTitleColor(.red, for: .normal)
    b.frame = CGRect(x: 25, y: 100, width: 500, height: 25)
    return b
}()
class MarketplaceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .gray
        
        // Test label -- Remove it later
        view.addSubview(viewLabel)
        // End test label
        viewLabel.addTarget(self, action: #selector(MarketplaceViewController.detailedButtonPressed(button:)), for: .touchUpInside)
    }

    @objc func detailedButtonPressed(button:UIButton){
        let mainVC = DetailedViewController()
        present(mainVC, animated: true, completion: nil)
        
    }
}
