//
//  MSPortfolioMetaInfoCell.swift
//  MockStock
//
//  Created by Theodore Hecht on 4/16/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSPortfolioMetaInfoCell: UICollectionViewCell {
    
    // MARK: View Properties
    var networth: UILabel = {
        let l = UILabel()
        l.text = "Net Worth:"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    var networthValue: UILabel = {
        let l = UILabel()
        l.text = "$13,000.42"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        return l
    }()
    var buyingPower: UILabel = {
        let l = UILabel()
        l.text = "Buying Power:"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    var buyingpowerValue: UILabel = {
        let l = UILabel()
        l.text = "$9,001.34"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        return l
    }()
    var portfolio: UILabel = {
        let l = UILabel()
        l.text = "Portfolio Value:"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    var portfolioValue: UILabel = {
        let l = UILabel()
        l.text = "$3,999.00"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .right
        return l
    }()
    
    // MARK: View Layout Code
    override func didMoveToSuperview() {
        addSubview(networth)
        addSubview(networthValue)
        addSubview(buyingPower)
        addSubview(buyingpowerValue)
        addSubview(portfolio)
        addSubview(portfolioValue)
        
        let leftInset = CGFloat(30.0)
        let rightInset = CGFloat(-30.0)
        
        networth.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        networth.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        networth.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        networth.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        networthValue.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        networthValue.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        networthValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        networthValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        buyingPower.topAnchor.constraint(equalTo: networth.bottomAnchor, constant: 10).isActive = true
        buyingPower.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftInset).isActive = true
        buyingPower.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        buyingPower.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        buyingpowerValue.topAnchor.constraint(equalTo: networth.bottomAnchor, constant: 10).isActive = true
        buyingpowerValue.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        buyingpowerValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        buyingpowerValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        portfolio.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 10).isActive = true
        portfolio.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftInset).isActive = true
        portfolio.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        portfolio.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        portfolioValue.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 10).isActive = true
        portfolioValue.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        portfolioValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        portfolioValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
