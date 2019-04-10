//
//  ViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 2/1/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    // MARK: Data Properties
    var portfolioData = MSPortfolioData.sharedInstance
    
    // MARK: View Properties
    var networkActivityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.style = .gray
        return v
    }()
    var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.backgroundColor = .white
        return v
    }()
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Navigation Controller
        self.navigationController?.navigationBar.topItem?.title = "Portfolio"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(logOut))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: networkActivityIndicator)

        // Configure View
        view.backgroundColor = .white
        
        // Add header views to the root view
        view.addSubview(networkActivityIndicator)
        
        // add collection view
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MSPortfolioItemCell.self, forCellWithReuseIdentifier: "PortfolioItem")
        collectionView.register(PortfolioMetaInfoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        // collection view constraints
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 45, right: 0)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
            layout.headerReferenceSize = CGSize(width: 100, height: 120)
        }
        
        fetchData()
    }
    
    func fetchData() {
        // 0. Start activity indicator animation
        networkActivityIndicator.startAnimating()
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send portfolio data request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/portfolio" // localhost:5001/api/tests"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            guard let data = data else { return }
            
            // Check for expired token
            if MSRestMock.checkUnauthorizedStatusCode(response: response) {
                print("unauthorized: getting token")
                MSRestMock.fetchAuthenticationToken(callback: self!.fetchData)
            }

            do {
                // Decode JSON
                let portfolio = try JSONDecoder().decode(PortfolioResponse.self, from: data)
                
                // Populate portfolio items from JSON
                var portfolioValue: Double = 0.0
                var items = [MSPortfolioItem]()
                for stock in portfolio.Stock {
                    let item = MSPortfolioItem()
                    item.symbol = stock.StockId
                    item.quantity = stock.StockQuantity
                    item.percentChange = stock.ChangePercent
                    item.price = stock.StockPrice
                    items.append(item)
                    
                    portfolioValue += (stock.StockPrice * Double(stock.StockQuantity))
                }
                let portfolioSingleton = MSPortfolioData.sharedInstance
                portfolioSingleton.items.removeAll()
                portfolioSingleton.items.append(contentsOf: items)
                portfolioSingleton.buyingPower = portfolio.UserCurrency
                portfolioSingleton.portfolioValue = portfolioValue
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.networkActivityIndicator.stopAnimating()
            }
        }.resume() // fires the session
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MSPortfolioData.sharedInstance.items.removeAll()
        MSPortfolioData.sharedInstance.buyingPower = 0
        MSPortfolioData.sharedInstance.portfolioValue = 0
        collectionView.reloadData()
    }
    @objc func logOut() {
        present(MSLoginViewController(), animated: false, completion: nil)
    }

}

extension PortfolioViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MSPortfolioData.sharedInstance.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelItem = MSPortfolioData.sharedInstance.items[indexPath.item]
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "PortfolioItem", for: indexPath) as! MSPortfolioItemCell
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .gray
        c.tickerLabel.text = modelItem.symbol.uppercased()
        c.priceValueLabel.text = String(format: "%.02f", modelItem.price)
        c.quantityValueLabel.text = String(modelItem.quantity)
        c.tcbValueLabel.text = String(format: "$%.02f", modelItem.price * Double(modelItem.quantity))
        
        var percentDoubleSign = ""
        if modelItem.percentChange >= 0 {
            percentDoubleSign = "+"
            c.setColors(topView: UIColor(red: 87, green: 210, blue: 2), bottomViewColor: UIColor(red: 70, green: 166, blue: 1))
        } else {
            percentDoubleSign = "-"
            c.setColors(topView: UIColor(red: 247, green: 13, blue: 31), bottomViewColor: UIColor(red: 191, green: 11, blue: 25))
        }
        c.valueLabel.text = String("\(percentDoubleSign)\(modelItem.percentChange)%")
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.width * 0.24)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! PortfolioMetaInfoCell
        headerCell.networthValue.text = String(format: "$%.02f", MSPortfolioData.sharedInstance.buyingPower + MSPortfolioData.sharedInstance.portfolioValue)
        headerCell.buyingpowerValue.text = String(format: "$%.02f", MSPortfolioData.sharedInstance.buyingPower)
        headerCell.portfolioValue.text = String(format: "$%.02f", MSPortfolioData.sharedInstance.portfolioValue)
        return headerCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelItem = portfolioData.items[indexPath.item]
        
        if let nav = navigationController {
            let vc = DetailedViewController()
            vc.symbolTitle = modelItem.symbol.uppercased()
            print(vc.symbolLabel)
            nav.pushViewController(vc, animated: true)
        }
    }
    
}

class PortfolioMetaInfoCell: UICollectionViewCell {
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
    
    override func didMoveToSuperview() {
        addSubview(networth)
        addSubview(networthValue)
        addSubview(buyingPower)
        addSubview(buyingpowerValue)
        addSubview(portfolio)
        addSubview(portfolioValue)
        
        let leftInset = CGFloat(30.0)
        let rightInset = CGFloat(-30.0)
        
        networth.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        networth.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        networth.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        networth.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        networthValue.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        networthValue.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        networthValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        networthValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        buyingPower.topAnchor.constraint(equalTo: networth.bottomAnchor, constant: 10).isActive = true
        buyingPower.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftInset).isActive = true
        buyingPower.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        buyingPower.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        buyingpowerValue.topAnchor.constraint(equalTo: networth.bottomAnchor, constant: 10).isActive = true
        buyingpowerValue.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        buyingpowerValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        buyingpowerValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        portfolio.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 10).isActive = true
        portfolio.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftInset).isActive = true
        portfolio.trailingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        portfolio.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        portfolioValue.topAnchor.constraint(equalTo: buyingPower.bottomAnchor, constant: 10).isActive = true
        portfolioValue.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        portfolioValue.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        portfolioValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
