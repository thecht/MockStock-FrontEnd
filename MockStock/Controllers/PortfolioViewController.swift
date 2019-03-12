//
//  ViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 2/1/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    // MARK: Properties
    var headerLabel: UILabel = {
        let l = UILabel()
        l.text = "Portfolio"
        l.font = UIFont(name: "Futura-CondensedExtraBold", size: 48)
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
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
    var divider: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.backgroundColor = .white
        v.register(MSPortfolioItemCell.self, forCellWithReuseIdentifier: "PortfolioItem")
        return v
    }()
    var portfolioItems = [MSPortfolioItem]()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        
        // Add header views to the root view
        view.addSubview(headerLabel)
        view.addSubview(networth)
        view.addSubview(networthValue)
        view.addSubview(buyingPower)
        view.addSubview(buyingpowerValue)
        view.addSubview(portfolio)
        view.addSubview(portfolioValue)
        view.addSubview(divider)
        
        // add collection view
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Add constraints to the header views
        let leftInset = CGFloat(30.0)
        let rightInset = CGFloat(-30.0)
        let topInset = CGFloat(30.0)
        
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        networth.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        networth.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        networth.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        networth.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        networthValue.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10).isActive = true
        networthValue.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        networthValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        networthValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        buyingPower.topAnchor.constraint(equalTo: networth.bottomAnchor, constant: 10).isActive = true
        buyingPower.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        buyingPower.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buyingPower.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        buyingpowerValue.topAnchor.constraint(equalTo: networth.bottomAnchor, constant: 10).isActive = true
        buyingpowerValue.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        buyingpowerValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        buyingpowerValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        portfolio.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 10).isActive = true
        portfolio.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leftInset).isActive = true
        portfolio.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        portfolio.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        portfolioValue.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 10).isActive = true
        portfolioValue.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        portfolioValue.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        portfolioValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        divider.topAnchor.constraint(equalTo: portfolio.bottomAnchor, constant: 30).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // collection view constraints
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        collectionView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.25)
        }
    }

}

extension PortfolioViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 //portfolioItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let modelItem = portfolioItems[indexPath.item]
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioItem", for: indexPath) as! MSPortfolioItemCell
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .yellow
        return c
    }
    
}

extension PortfolioViewController: UICollectionViewDelegate {
    
}

class MSPortfolioItemCell: UICollectionViewCell {
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        print(self.frame)
    }
}
