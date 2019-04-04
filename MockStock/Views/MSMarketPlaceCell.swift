//
//  MSMarketPlaceCell.swift
//  MockStock
//
//  Created by Luke Orr on 4/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSMarketPlaceCell: UICollectionViewCell{
    
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "AAPL")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    var priceLabel: UILabel = {
        let l = UILabel()
        l.text = "PRICE:"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        l.textColor = .black
        l.textAlignment = .left
        return l
    }()
    var priceValueLabel: UILabel = {
        let l = UILabel()
        l.text = "123.12"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        l.textColor = .black
        l.textAlignment = .left
        return l
    }()
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
    var tickerLabel: UILabel = {
        let l = UILabel()
        l.text = "APPL"
        l.font = UIFont(name: "Futura", size: 18)
        l.textColor = .black
        l.textAlignment = .left
        return l
    }()
    var valuePercentLabel: UILabel = {
        let l = UILabel()
        l.text = "+3.08%"
        l.font = UIFont(name: "Futura", size: 20)
        l.textColor = .black
        l.textAlignment = .left
        return l
    }()
    var percentLabel: UILabel = {
        let l = UILabel()
        l.text = "Today's Change: "
        l.font = UIFont(name: "Futura", size: 20)
        l.textColor = .black
        l.textAlignment = .left
        return l
    }()
    var divider: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var categoryLabel: UILabel = {
        let l = UILabel()
        l.text = "Today's Winners"
        l.font = UIFont(name: "Futura", size: 20)
        l.textColor = .black
        l.textAlignment = .left
        return l
    }()
    override init(frame:CGRect){
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupViews(){
        
        addSubview(imageView)
        addSubview(divider)
        addSubview(priceLabel)
        addSubview(priceValueLabel)
        addSubview(tickerLabel)
        addSubview(valuePercentLabel)
        addSubview(divider)
        addSubview(percentLabel)
        
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
        let leftLabelInset = CGFloat(5.0)
        imageView.frame = CGRect(x: leftLabelInset, y: 150, width: 30, height: 30)
        divider.frame = CGRect(x: 0, y: 185, width: frame.width, height: 1)
        tickerLabel.frame = CGRect(x: 40, y: 140, width: 50, height: 50)
        priceLabel.frame = CGRect(x: 3, y: 175, width: 50, height: 50)
        priceValueLabel.frame = CGRect(x: 43, y: 175, width: 100, height: 50)
        valuePercentLabel.frame = CGRect(x: 3, y: 200, width: 100, height: 50)
        categoryLabel.frame = CGRect(x: 3, y: 200, width: 100, height: 50)
    }
    func setColors(topView: UIColor, bottomViewColor: UIColor) {
        self.backgroundColor = topView
        self.colorView1.backgroundColor = bottomViewColor
        self.colorView2.backgroundColor = bottomViewColor
    }
}
