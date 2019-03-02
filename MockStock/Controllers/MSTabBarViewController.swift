//
//  MSTabBarViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/2/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSTabBarViewController: UIViewController {
    
    // Tab bar widgets
    var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        return v
    }()
    var pageIndicator: UIView = {
        return UIView()
    }()
    var portfolioButton: UIButton = {
        return UIButton()
    }()
    var marketplaceButton: UIButton = {
        return UIButton()
    }()
    var leaguesButton: UIButton = {
        return UIButton()
    }()
    
    // ViewController Pages
    var portfolioViewController: PortfolioViewController!
    var marketplaceViewController: UIViewController!
    var leaguesViewController: UIViewController!
    
    // MARK: View Controller lifecycle methods
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        view.addSubview(contentView)
        contentView.addSubview(portfolioButton)
        contentView.addSubview(marketplaceButton)
        contentView.addSubview(leaguesButton)
        contentView.addSubview(pageIndicator)
        
        // autolayout constraints
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75).isActive = true
        
        
    }
}
