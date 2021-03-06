//
//  ViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 2/1/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit

class MSPortfolioViewController: UIViewController {
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
    
    // MARK: ViewController Methods
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
        
        // Add and configure collection view
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MSPortfolioItemCell.self, forCellWithReuseIdentifier: "PortfolioItem")
        collectionView.register(MSPortfolioMetaInfoCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        // Collection view constraints
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MSPortfolioData.sharedInstance.items.removeAll()
        MSPortfolioData.sharedInstance.buyingPower = 0
        MSPortfolioData.sharedInstance.portfolioValue = 0
        collectionView.reloadData()
    }
    
    // MARK: API Methods
    func fetchData() {
        // 0. Start activity indicator animation
        networkActivityIndicator.startAnimating()
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSAPI.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send portfolio data request to server using authentication token
        // 2.1 - Configure HTTP request
        let urlString = "\(MSAPI.baseUrl)/api/portfolio"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        
        // 2.2 - Send & response to HTTP request
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            guard let data = data else { return }
            
            // Check for expired token
            if MSAPI.checkUnauthorizedStatusCode(response: response) {
                print("unauthorized: getting token")
                MSAPI.fetchAuthenticationToken(callback: self!.fetchData)
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
            
            // Clean up UI after response recieved
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.networkActivityIndicator.stopAnimating()
            }
        }.resume() // fires the session
    }
    
    @objc func logOut() {
        present(MSLoginViewController(), animated: false, completion: nil)
    }

}

// MARK: UICollectionView Data Source implementation
extension MSPortfolioViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! MSPortfolioMetaInfoCell
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
