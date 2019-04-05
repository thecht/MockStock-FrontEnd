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
    var marketPlaceData = MSMarketPlaceData.sharedInstance
    var gainersData = MSWinnersData.sharedInstance
    var losersData = MSLosersData.sharedInstance
    var WinnersCollectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    private let winnersId = "winnersId"
    private let marketId = "marketId"
    private let losersId = "losersId"
    //var marketPlaceCategories: [MarketPlaceCategory]?
    var button = dropDownBtn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button  = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setImage(UIImage(named: "dropdownicon"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.dropView.dropDownOptions = ["Ascending", "Descending"]
        self.navigationController?.navigationBar.topItem?.title = "MarketPlace"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView:button)
        view.backgroundColor = .white
        //marketPlaceCategories = MarketPlaceCategory.sampleStockCategories()
        view.addSubview(WinnersCollectionView)
        WinnersCollectionView.delegate = self
        WinnersCollectionView.dataSource = self
        WinnersCollectionView.register(MSMarketPlaceCell.self, forCellWithReuseIdentifier: marketId)
        WinnersCollectionView.register(MSFeaturedItemCell.self, forCellWithReuseIdentifier: winnersId)
        WinnersCollectionView.register(MSFeaturedItemCell.self, forCellWithReuseIdentifier: losersId)
        
        // collection view constraints
        WinnersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        WinnersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        WinnersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        WinnersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        if let layout = WinnersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 45, right: 0)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
        }
        fetchData()
    }
    func fetchData() {
        // 0. Start activity indicator animation
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send portfolio data request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/stock/marketplace" // localhost:5001/api/tests"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET(marketplace)"
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
                //let data2 = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                /*let marketplace = try JSONDecoder().decode(MarketResponse.stocks.self, from: data2 as! Data)
                let marketplaceGainers = try JSONDecoder().decode(MarketResponse.gainers.self, from: data2 as! Data)
                let marketplaceLosers = try JSONDecoder().decode(MarketResponse.losers.self, from: data2 as! Data)*/
                print("test")
                let marketplace = try JSONDecoder().decode(MarketResponse.self, from: data)
                print("test")
                // Populate portfolio items from JSON
                var items = [MSMarketPlaceItem]()
                var winnersItems = [MSMarketPlaceItem]()
                var losersItems = [MSMarketPlaceItem]()
                for marketStock in marketplace.stocks {
                    let item = MSMarketPlaceItem()
                    item.symbol = marketStock.symbol
                    item.percent = Double(truncating: marketStock.changePercent as NSNumber)
                    item.imageName = marketStock.logo
                    item.price = Double(truncating: marketStock.price as NSNumber)
                    items.append(item)
                }
                for marketStock in marketplace.gainers {
                    let item = MSMarketPlaceItem()
                    item.symbol = marketStock.symbol
                    item.percent = Double(truncating: marketStock.changePercent as NSNumber)
                    item.imageName = marketStock.logo
                    item.price = Double(truncating: marketStock.price as NSNumber)
                    winnersItems.append(item)
                }
                for marketStock in marketplace.losers {
                    let item = MSMarketPlaceItem()
                    item.symbol = marketStock.symbol
                    item.percent = Double(truncating: marketStock.changePercent as NSNumber)
                    item.imageName = marketStock.logo
                    item.price = Double(truncating: marketStock.price as NSNumber)
                    losersItems.append(item)
                }
                let marketPlaceSingleton = MSMarketPlaceData.sharedInstance
                marketPlaceSingleton.items.removeAll()
                marketPlaceSingleton.items.append(contentsOf: items)
                let gainersSingleton = MSWinnersData.sharedInstance
                gainersSingleton.items.removeAll()
                gainersSingleton.items.append(contentsOf: winnersItems)
                let losersSingleton = MSLosersData.sharedInstance
                losersSingleton.items.removeAll()
                losersSingleton.items.append(contentsOf: losersItems)
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                self?.WinnersCollectionView.reloadData()
            }
            }.resume() // fires the session
    }
    
    @objc func logOut() {
        present(MSLoginViewController(), animated: false, completion: nil)
    }
    
}

protocol dropDownProtocol {
    func dropDownPressed(string : String)
}

class dropDownBtn: UIButton, dropDownProtocol {
    
    func dropDownPressed(string: String) {
        self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    var dropView = dropDownView()
    
    var height = NSLayoutConstraint()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropView.delegate = self
        dropView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubviewToFront(dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -30).isActive = true
        //dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropView.widthAnchor.constraint(equalToConstant: 130).isActive = true
        //dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            
            isOpen = true
            
            NSLayoutConstraint.deactivate([self.height])
            
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant = 150
            } else {
                self.height.constant = self.dropView.tableView.contentSize.height
            }
            
            
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height / 2
            }, completion: nil)
            
        } else {
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            }, completion: nil)
            
        }
    }
    
    func dismissDropDown() {
        isOpen = false
        NSLayoutConstraint.deactivate([self.height])
        self.height.constant = 0
        NSLayoutConstraint.activate([self.height])
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.dropView.center.y -= self.dropView.frame.height / 2
            self.dropView.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource  {
    
    var dropDownOptions = [String]()
    
    var tableView = UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.white
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = dropDownOptions[indexPath.row]
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
extension MarketplaceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            //let modelItem = MSWinnersData.sharedInstance.items[indexPath.item]
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: winnersId, for: indexPath)as!MSFeaturedItemCell
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.backgroundColor = . gray
            cell.categoryLabel.text = "Todays Winners"
            return cell
        } else if indexPath.section == 1{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: losersId, for: indexPath)as!MSFeaturedItemCell
            
            cell.categoryLabel.text = "Todays Losers"
            return cell
            
        }else{
            let modelItem = MSMarketPlaceData.sharedInstance.items[indexPath.item]
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: marketId, for: indexPath)as!MSMarketPlaceCell
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.backgroundColor = .gray
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
            cell.priceValueLabel.text = String("\(percentDoubleSign)\(modelItem.percent)%")
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2{
            return MSMarketPlaceData.sharedInstance.items.count
        }
        else if section == 1{
           return 1
        }
        else{
           return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 2{
            return CGSize(width: 110, height: 110)
        }
        return CGSize(width: collectionView.frame.width , height: 150)
    }
    
}
    
