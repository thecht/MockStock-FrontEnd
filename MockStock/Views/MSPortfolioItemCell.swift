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
    var priceLabel: UILabel!
    var priceValueLabel: UILabel!
    var quantityLabel: UILabel!
    var quantityValueLabel: UILabel!
    var tcbLabel: UILabel!
    var tcbValueLabel: UILabel!
    var tickerLabel: UILabel!
    var valuePercentLabel: UILabel!
    var valueLabel: UILabel!
    
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
        
        
        
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Size background views
        colorView2.frame = CGRect(x: 0, y: frame.height - frame.height * 0.4, width: frame.width, height: frame.height * 0.4)
        colorView2.layer.cornerRadius = colorView2.frame.width / 25
        colorView1.frame = CGRect(x: 0, y: frame.height - frame.height * 0.5, width: frame.width, height: frame.height * 0.2)
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
