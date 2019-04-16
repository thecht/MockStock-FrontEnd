//
//  MSLeagueUserCell.swift
//  MockStock
//
//  Created by Theodore Hecht on 4/16/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSLeagueUserCell: UICollectionViewCell {
    
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
    var userName: UILabel = {
        let l = UILabel()
        l.text = "Someone"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 24)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var netWorth: UILabel = {
        let l = UILabel()
        l.text = "$500"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 24)
        l.textColor = .white
        l.textAlignment = .right
        return l
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        // Configure view properties
        layer.cornerRadius = self.frame.width / 25
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 4.0
        clipsToBounds = true
        
        // Add & Configure subviews
        addSubview(colorView1)
        addSubview(colorView2)
        addSubview(userName)
        addSubview(netWorth)
        
        //netWorth.textAlignment = .right
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Size background views
        colorView2.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.5)
        colorView1.frame = CGRect(x: 0, y: frame.height * 0.5, width: frame.width, height: frame.height * 0.5)
        
        // Size labels
        userName.frame = CGRect(x: 15, y: frame.height/2 - 20, width: frame.width, height: 40)
        netWorth.frame = CGRect(x: frame.width/2, y: frame.height/2 - 20, width: frame.width/2 - 15, height: 40)
//        setupLabels()
    }
    
//    private func setupLabels() {
//        userName.frame = CGRect(x: 15, y: frame.height/2 - 20, width: frame.width, height: 40)
//        netWorth.frame = CGRect(x: frame.width/2, y: frame.height/2 - 20, width: frame.width/2 - 15, height: 40)
//    }
    
    func setColors(topView: UIColor, bottomViewColor: UIColor) {
        self.backgroundColor = topView
        self.colorView1.backgroundColor = topView
        self.colorView2.backgroundColor = bottomViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
