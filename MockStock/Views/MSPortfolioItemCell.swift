//
//  MSPortfolioItemCell.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/15/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSPortfolioItemCell: UICollectionViewCell {
    
    // Background bars
    var colorView1: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }()
    var colorView2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }()
    
    // Labels
    var priceLabel: UILabel = {
        let l = UILabel()
        l.text = "PRICE:"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var priceValueLabel: UILabel = {
        let l = UILabel()
        l.text = "123.12"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var quantityLabel: UILabel = {
        let l = UILabel()
        l.text = "QTY:"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var quantityValueLabel: UILabel = {
        let l = UILabel()
        l.text = "71"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var tcbLabel: UILabel = {
        let l = UILabel()
        l.text = "TOTAL VALUE:"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var tcbValueLabel: UILabel = {
        let l = UILabel()
        l.text = "$70981.21"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 22)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var tickerLabel: UILabel = {
        let l = UILabel()
        l.text = "APPL"
        l.font = UIFont(name: "Futura", size: 22)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var valuePercentLabel: UILabel = {
        let l = UILabel()
        l.text = "+3.08%"
        l.font = UIFont(name: "Futura", size: 22)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var valueLabel: UILabel = {
        let l = UILabel()
        l.text = "$12,345"
        l.font = UIFont(name: "Futura", size: 22)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        // Configure view properties
        layer.cornerRadius = self.frame.width / 25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4.0
        
        // Add & Configure subviews
        addSubview(colorView1)
        addSubview(colorView2)
        
        addSubview(priceLabel)
        addSubview(priceValueLabel)
        addSubview(quantityLabel)
        addSubview(quantityValueLabel)
        addSubview(tcbLabel)
        addSubview(tcbValueLabel)
        addSubview(tickerLabel)
        //addSubview(valuePercentLabel)
        addSubview(valueLabel)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Size background views
        colorView2.frame = CGRect(x: 0, y: frame.height - frame.height * 0.4, width: frame.width, height: frame.height * 0.4)
        colorView2.layer.cornerRadius = colorView2.frame.width / 25
        colorView1.frame = CGRect(x: 0, y: frame.height - frame.height * 0.4, width: frame.width, height: frame.height * 0.2)
    
        setupLabels()
    }
    
    private func setupLabels() {
        let leftLabelInset = CGFloat(10.0)
        priceLabel.frame = CGRect(x: leftLabelInset, y: 5.0, width: 115.0, height: 20.0)
        priceValueLabel.frame = CGRect(x: leftLabelInset, y: priceLabel.frame.height + 5.0, width: 115.0, height: 25.0)
        quantityLabel.frame = CGRect(x: leftLabelInset + priceLabel.frame.width, y: 5.0, width: 85.0, height: 20.0)
        quantityValueLabel.frame = CGRect(x: leftLabelInset + priceLabel.frame.width, y: quantityLabel.frame.height + 5.0, width: 70.0, height: 25.0)
        tcbLabel.frame = CGRect(x: quantityLabel.frame.maxX, y: 5.0, width: 120.0, height: 20.0)
        tcbValueLabel.frame = CGRect(x: quantityLabel.frame.maxX, y: tcbLabel.frame.height + 5.0, width: 120.0, height: 25.0)
        tickerLabel.frame = CGRect(x: leftLabelInset, y: colorView1.frame.minY + 5.0, width: 120, height: 30)
        valuePercentLabel.frame = CGRect(x: tickerLabel.frame.maxX - 30, y: tickerLabel.frame.minY, width: 115, height: 30)
        valueLabel.frame = CGRect(x: valuePercentLabel.frame.maxX, y: tickerLabel.frame.minY, width: 120, height: 30)
    }
    
    func setColors(topView: UIColor, bottomViewColor: UIColor) {
        self.backgroundColor = topView
        self.colorView1.backgroundColor = bottomViewColor
        self.colorView2.backgroundColor = bottomViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
