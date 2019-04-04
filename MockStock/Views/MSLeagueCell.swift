//
//  MSLeagueCell.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/27/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSLeagueCell: UICollectionViewCell {
    
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
    var leagueName: UILabel = {
        let l = UILabel()
        l.text = "The Mighty Nine"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 24)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var leagueCode: UILabel = {
        let l = UILabel()
        l.text = "CODE: 4PQ-ZM1"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 16)
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
        
        addSubview(leagueName)
        addSubview(leagueCode)
        
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
        leagueName.frame = CGRect(x: 15, y: colorView1.frame.height/2, width: frame.width, height: 40)
        leagueCode.frame = CGRect(x: 15, y: colorView1.frame.minY + 5.0, width: frame.width, height: 30)
        //        priceLabel.frame = CGRect(x: leftLabelInset, y: 5.0, width: 115.0, height: 20.0)
        //        priceValueLabel.frame = CGRect(x: leftLabelInset, y: priceLabel.frame.height + 5.0, width: 115.0, height: 25.0)
        //        quantityLabel.frame = CGRect(x: leftLabelInset + priceLabel.frame.width, y: 5.0, width: 85.0, height: 20.0)
        //        quantityValueLabel.frame = CGRect(x: leftLabelInset + priceLabel.frame.width, y: quantityLabel.frame.height + 5.0, width: 70.0, height: 25.0)
        //        tcbLabel.frame = CGRect(x: quantityLabel.frame.maxX, y: 5.0, width: 120.0, height: 20.0)
        //        tcbValueLabel.frame = CGRect(x: quantityLabel.frame.maxX, y: tcbLabel.frame.height + 5.0, width: 120.0, height: 25.0)
        //        tickerLabel.frame = CGRect(x: leftLabelInset, y: colorView1.frame.minY + 5.0, width: 120, height: 30)
        //        valuePercentLabel.frame = CGRect(x: tickerLabel.frame.maxX - 30, y: tickerLabel.frame.minY, width: 115, height: 30)
        //        valueLabel.frame = CGRect(x: valuePercentLabel.frame.maxX, y: tickerLabel.frame.minY, width: 120, height: 30)
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
