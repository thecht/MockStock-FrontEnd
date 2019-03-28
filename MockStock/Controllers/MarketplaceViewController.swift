//
//  MarketplaceViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit




class MarketplaceViewController: UIViewController {
    var headerLabel: UILabel = {
        let l = UILabel()
        l.text = "MarketPlace"
        l.font = UIFont(name: "Futura-CondensedExtraBold", size: 48)
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
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
    var divider: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var WinnersCollectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.backgroundColor = .white
        return v
    }()
    var MainCollectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.backgroundColor = .green
        return v
    }()
    
    private let cellId = "cellId"
    
    var marketPlaceCategories: [MarketPlaceCategory]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        marketPlaceCategories = MarketPlaceCategory.sampleStockCategories()
        view.addSubview(headerLabel)
        view.addSubview(buyingPower)
        view.addSubview(divider)
        view.addSubview(buyingpowerValue)
        view.addSubview(WinnersCollectionView)
        WinnersCollectionView.delegate = self
        WinnersCollectionView.dataSource = self
        WinnersCollectionView.backgroundColor = UIColor.white
        WinnersCollectionView.register(MSFeaturedItemCell.self, forCellWithReuseIdentifier: cellId)
        setupLayout()
        changeMarketPlaceMetaData()
        
    }
    func setupLayout(){
        let leftInset = CGFloat(30.0)
        let rightInset = CGFloat(-30.0)
        let topInset = CGFloat(30.0)
        
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buyingPower.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        buyingPower.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        buyingPower.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buyingPower.heightAnchor.constraint(equalToConstant: 25).isActive = true
        buyingpowerValue.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        buyingpowerValue.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buyingpowerValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        buyingpowerValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        divider.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 30).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        WinnersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        WinnersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        WinnersCollectionView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 0).isActive = true
        WinnersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }
    func changeMarketPlaceMetaData() {
       
        buyingpowerValue.text = String(format: "$%.02f", MSPortfolioData.sharedInstance.buyingPower)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        if let layout = WinnersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 45, right: 0)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
        }
    }
}
extension MarketplaceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as!MSFeaturedItemCell
        
        cell.marketPlaceCategory = (marketPlaceCategories?[indexPath.item])!
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = marketPlaceCategories?.count{
            return count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 0, height: 140)
    }
    
    func detailedButtonPressed(button:UIButton){
        let mainVC = DetailedViewController()
        present(mainVC, animated: true, completion: nil)
        
    }
    
    
    /*class MSFeaturedItemCell: UICollectionViewCell {
        override init(frame:CGRect){
            super.init(frame: frame)
            setupViews()
        }
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func setupViews() {
            backgroundColor = UIColor.black
        }*/
    
}
