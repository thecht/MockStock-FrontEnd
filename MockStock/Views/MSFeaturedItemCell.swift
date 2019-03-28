//
//  MSMarketPlaceItemCell.swift
//  MockStock
//
//  Created by Luke Orr on 3/27/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit



class MSFeaturedItemCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var marketPlaceCategory: MarketPlaceCategory? {
        didSet{
            
            if let name = marketPlaceCategory?.name {
                categoryLabel.text = name
            }
            
        }
        
    }
    var categoryLabel: UILabel = {
        let l = UILabel()
        l.text = "Today's Winners"
        l.font = UIFont(name: "HelveticaNeue-Thin", size: 14)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textAlignment = .left
        return l
    }()
    
    var dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let cellId = "featuredCellId"
    override init(frame:CGRect){
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let featuredCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    

    func setupViews() {
        backgroundColor = UIColor.clear
        
        addSubview(featuredCollectionView)
        addSubview(categoryLabel)
        addSubview(dividerLineView)
        featuredCollectionView.dataSource = self
        featuredCollectionView.delegate = self
        featuredCollectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: cellId)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : categoryLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : featuredCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[categoryLabel(30)][v0][v1(0.5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : featuredCollectionView, "v1": dividerLineView, "categoryLabel": categoryLabel]))
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = marketPlaceCategory?.stocks?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as!FeaturedCell
        cell.stock = marketPlaceCategory?.stocks?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: collectionView.frame.width - 30)
    }
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class FeaturedCell: UICollectionViewCell{
    
    var stock: stock? {
        didSet{
            if let name = stock?.tickerSymbol{
            tickerLabel.text = name
            }
            if let price = stock?.price{
                priceValueLabel.text = "$\(price)"
            } else{
                priceValueLabel.text = ""
            }
            if let imageName = stock?.imageName{
                imageView.image = UIImage(named: imageName)
            }
            if let percent = stock?.percent{
                valuePercentLabel.text = "\(percent)%"
            } else{
                valuePercentLabel.text = ""
            }
        }
    }
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
        backgroundColor = UIColor.white
        let leftLabelInset = CGFloat(5.0)
        imageView.frame = CGRect(x: leftLabelInset, y: 150, width: 30, height: 30)
        divider.frame = CGRect(x: 0, y: 185, width: frame.width, height: 1)
        tickerLabel.frame = CGRect(x: 40, y: 140, width: 50, height: 50)
        priceLabel.frame = CGRect(x: 3, y: 175, width: 50, height: 50)
        priceValueLabel.frame = CGRect(x: 43, y: 175, width: 100, height: 50)
        valuePercentLabel.frame = CGRect(x: 3, y: 200, width: 100, height: 50)
        categoryLabel.frame = CGRect(x: 3, y: 200, width: 100, height: 50)
    }
}
