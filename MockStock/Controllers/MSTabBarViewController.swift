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
    var separationBar: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.gray
        return v
    }()
    var pageIndicator: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.clipsToBounds = true
        v.backgroundColor = UIColor.black
        return UIView()
    }()
    var portfolioButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("PORTFOLIO", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.black, for: .normal)
        b.tag = 0
        return b
    }()
    var marketplaceButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("MARKETPLACE", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.gray, for: .normal)
        b.tag = 1
        return b
    }()
    var leaguesButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("LEAGUES", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.gray, for: .normal)
        b.tag = 2
        return b
    }()
    
    // 
    var barButtons = [UIButton]()
    var viewControllers = [UIViewController]()
    var currentlySelectedButton: UIButton!
    
    // MARK: View Controller lifecycle methods
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear
        
        // Create the view controllers
        //viewControllers.append(PortfolioViewController())
        viewControllers.append(UINavigationController(rootViewController: PortfolioViewController()))
        viewControllers.append(UINavigationController(rootViewController: MarketplaceViewController()))
        viewControllers.append(UINavigationController(rootViewController: LeaguesViewController()))
        
        // Add buttons to buttons array
        barButtons.append(portfolioButton)
        barButtons.append(marketplaceButton)
        barButtons.append(leaguesButton)
        
        // Add views to screen
        view.addSubview(contentView)
        contentView.addSubview(separationBar)
        contentView.addSubview(portfolioButton)
        contentView.addSubview(marketplaceButton)
        contentView.addSubview(leaguesButton)
        contentView.addSubview(pageIndicator)
        
        // Flag portfolio as initial screen
        currentlySelectedButton = portfolioButton
        self.addChild(viewControllers[0])
        view.insertSubview(viewControllers[0].view, belowSubview: contentView)
        
        // Add autolayout constraints
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75).isActive = true
        
        separationBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separationBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separationBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        separationBar.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        portfolioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        portfolioButton.trailingAnchor.constraint(equalTo: marketplaceButton.leadingAnchor).isActive = true
        portfolioButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        portfolioButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        portfolioButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3333).isActive = true
        
        marketplaceButton.leadingAnchor.constraint(equalTo: portfolioButton.trailingAnchor).isActive = true
        marketplaceButton.trailingAnchor.constraint(equalTo: leaguesButton.leadingAnchor).isActive = true
        marketplaceButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        marketplaceButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        marketplaceButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3333).isActive = true
        
        leaguesButton.leadingAnchor.constraint(equalTo: marketplaceButton.trailingAnchor).isActive = true
        leaguesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        leaguesButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        leaguesButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        
        // Add button touch handlers
        portfolioButton.addTarget(self, action: #selector(MSTabBarViewController.barButtonPressed(button:)), for: .touchUpInside)
        marketplaceButton.addTarget(self, action: #selector(MSTabBarViewController.barButtonPressed(button:)), for: .touchUpInside)
        leaguesButton.addTarget(self, action: #selector(MSTabBarViewController.barButtonPressed(button:)), for: .touchUpInside)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // If keychain data doesn't exist, then present login vc.
        
    }
    
    @objc func barButtonPressed(button: UIButton) {
        // Dont press if already selected.
        if button == currentlySelectedButton { return }
        
        // Flag new button as selected.
        currentlySelectedButton = button
        
        // Swap View Controllers.
        for vc in children {
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        self.addChild(viewControllers[button.tag])
        view.insertSubview(viewControllers[button.tag].view, belowSubview: contentView)
        
        // Change tab bar button colors.
        for btn in barButtons {
            if btn == button {
                btn.setTitleColor(.black, for: .normal)
            } else {
                btn.setTitleColor(.gray, for: .normal)
            }
        }
        
    }
    
    
}
