//
//  MSMarketPlaceItemCell.swift
//  MockStock
//
//  Created by Luke Orr on 3/27/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class testClass: UICollectionView{
    
}

class MSFeaturedItemCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let winnersId = "winnersId"
    private let losersId = "losersId"
    var detailedViewController: DetailedViewController?
    let label : String = ""
    
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
    
    func configure(){
        let count = MSWinnersData.sharedInstance.items.count
        print("count")
        print(count)
    }
    func setup(){
        featuredCollectionView.reloadData()
    }
    
    var featuredCollectionView: UICollectionView = {
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
        featuredCollectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: winnersId)
        featuredCollectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: losersId)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : categoryLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : featuredCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[categoryLabel(30)][v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : featuredCollectionView, "categoryLabel": categoryLabel]))
        if let layout = featuredCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 22
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return MSWinnersData.sharedInstance.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let modelItem = MSWinnersData.sharedInstance.items[indexPath.item]
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: winnersId, for: indexPath)as!FeaturedCell
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.backgroundColor = .clear
            cell.tickerLabel.text = modelItem.symbol.uppercased()
            cell.priceValueLabel.text = String(format: "%.02f", modelItem.price)
            var percentDoubleSign = ""
            if modelItem.percent >= 0 {
             percentDoubleSign = "+"
             cell.setColors(topView: UIColor(red: 87, green: 210, blue: 2), bottomViewColor: UIColor(red: 70, green: 166, blue: 1))
             } else {
             percentDoubleSign = "-"
             cell.setColors(topView: UIColor(red: 247, green: 13, blue: 31), bottomViewColor: UIColor(red: 191, green: 11, blue: 25))
             }
            let percentStr = String(format: "%.03f", modelItem.percent)
            cell.valuePercentLabel.text = String("\(percentDoubleSign)\(percentStr)%")
            let url = URL(string: modelItem.imageName)
            do{
                let data = try Data(contentsOf: url!)
                cell.imageView.image = UIImage(data: data)
            }catch let err{
                cell.imageView.image = UIImage(named: "AAPL")
            }
            return cell
        }
        


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class FeaturedCell: UICollectionViewCell{
    
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
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var priceValueLabel: UILabel = {
        let l = UILabel()
        l.text = "123.12"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        l.textColor = .white
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
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var valuePercentLabel: UILabel = {
        let l = UILabel()
        l.text = "+3.08%"
        l.font = UIFont(name: "Futura", size: 20)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var percentLabel: UILabel = {
        let l = UILabel()
        l.text = "Today's Change: "
        l.font = UIFont(name: "Futura", size: 20)
        l.textColor = .white
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
    func configure(){
        
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLabels()
    }
    private func setupLabels() {
        let leftLabelInset = CGFloat(5.0)
        imageView.frame = CGRect(x: leftLabelInset, y: 0, width: 30, height: 30)
        divider.frame = CGRect(x: 0, y: 35, width: frame.width, height: 1)
        tickerLabel.frame = CGRect(x: 40, y: 0, width: 70, height: 50)
        priceLabel.frame = CGRect(x: 3, y: 25, width: 50, height: 50)
        priceValueLabel.frame = CGRect(x: 43, y: 25, width: 100, height: 50)
        valuePercentLabel.frame = CGRect(x: 3, y: 50, width: 100, height: 50)
    }
    func setColors(topView: UIColor, bottomViewColor: UIColor) {
        self.backgroundColor = topView
        self.colorView1.backgroundColor = bottomViewColor
        self.colorView2.backgroundColor = bottomViewColor
    }
}
class MSLosersItemCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let losersId = "losersId"
    var label = ""
    
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
    
    func configure(){
        let count = MSWinnersData.sharedInstance.items.count
        print("count")
        print(count)
    }
    func setup(){
        featuredCollectionView.reloadData()
    }
    
    var featuredCollectionView: UICollectionView = {
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
        featuredCollectionView.register(FeaturedCell.self, forCellWithReuseIdentifier: losersId)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : categoryLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : featuredCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[categoryLabel(30)][v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : featuredCollectionView, "categoryLabel": categoryLabel]))
        if let layout = featuredCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 22
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MSLosersData.sharedInstance.items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let modelItem = MSLosersData.sharedInstance.items[indexPath.item]
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: losersId, for: indexPath)as!FeaturedCell
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = .clear
        cell.tickerLabel.text = modelItem.symbol.uppercased()
        cell.priceValueLabel.text = String(format: "%.02f", modelItem.price)
        var percentDoubleSign = ""
        if modelItem.percent >= 0 {
         percentDoubleSign = "+"
         cell.setColors(topView: UIColor(red: 87, green: 210, blue: 2), bottomViewColor: UIColor(red: 70, green: 166, blue: 1))
         } else {
         percentDoubleSign = "-"
         cell.setColors(topView: UIColor(red: 247, green: 13, blue: 31), bottomViewColor: UIColor(red: 191, green: 11, blue: 25))
         }
        let percentStr = String(format: "%.03f", modelItem.percent)
        cell.valuePercentLabel.text = String("\(percentDoubleSign)\(percentStr)%")
        let url = URL(string: modelItem.imageName)
        do{
            let data = try Data(contentsOf: url!)
            cell.imageView.image = UIImage(data: data)
        }catch let err{
            cell.imageView.image = UIImage(named: "AAPL")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        let modelItem = MSLosersData.sharedInstance.items[indexPath.item]
        label = modelItem.symbol
        print(label)
    }
    func getItem() -> String{
        print("lavel")
        print(label)
        return label
    }
    
}

