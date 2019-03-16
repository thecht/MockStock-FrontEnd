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
        
        //        // Configure view properties
        //        layer.cornerRadius = self.frame.width / 3
        //        layer.shadowColor = UIColor.black.cgColor
        //        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        //        layer.shadowOpacity = 0.4
        //        layer.shadowRadius = 4.0
        //
        //        // Add & Configure subviews
        //        addSubview(colorView1)
        //        addSubview(colorView2)
        //
        //        colorView2.layer.cornerRadius = layer.cornerRadius
        //
        //        colorView2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        //        colorView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        //        colorView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        //        colorView2.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0.333).isActive = true
        
        
        colorView2.frame = CGRect(x: 0, y: frame.height - frame.height * 0.4, width: frame.width, height: frame.height * 0.4)
        colorView2.layer.cornerRadius = colorView2.frame.width / 25
        
        colorView1.frame = CGRect(x: 0, y: frame.height - frame.height * 0.5, width: frame.width, height: frame.height * 0.2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
