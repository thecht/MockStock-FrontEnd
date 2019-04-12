//
//  MarketplaceViewController.swift
//  MockStock
//
//  Created by Luke Orr on 3/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit



class MarketplaceViewController: UIViewController, UISearchBarDelegate {
    var ascSortButton: UIBarButtonItem!
    var decSortButton: UIBarButtonItem!
    var sort: String = "asc"
    var isSearching: Bool = false
    var marketPlaceData = MSMarketPlaceData.sharedInstance
    var gainersData = MSWinnersData.sharedInstance
    var losersData = MSLosersData.sharedInstance
    var testCollectionView = MSFeaturedItemCell()
    var losersCollectionView = MSLosersItemCell()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "MarketPlace"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        
        ascSortButton = UIBarButtonItem(title: "Sort: A-Z", style: .plain, target: self, action: #selector(didTapAsc))
        decSortButton = UIBarButtonItem(title: "Sort: Z-A", style: .plain, target: self, action: #selector(didTapDec))
        self.navigationItem.rightBarButtonItem = self.ascSortButton
        
        view.backgroundColor = .white
        view.addSubview(WinnersCollectionView)
        searchBar.delegate = self
        WinnersCollectionView.delegate = self
        WinnersCollectionView.dataSource = self
        WinnersCollectionView.register(MSMarketPlaceCell.self, forCellWithReuseIdentifier: marketId)
        WinnersCollectionView.register(MSFeaturedItemCell.self, forCellWithReuseIdentifier: winnersId)
        WinnersCollectionView.register(MSLosersItemCell.self, forCellWithReuseIdentifier: losersId)
        WinnersCollectionView.register(Header.self, forCellWithReuseIdentifier: "header")
        // collection view constraints
        WinnersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        WinnersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        WinnersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        WinnersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
 
    }
    //Function that calls fetchdata method to sort by decending if the button was hit
    @objc func didTapAsc(){
        self.navigationItem.setRightBarButton(self.decSortButton, animated: false)
        fetchData(sortString: "dec")
        
    }
    //Function that calls fetchdata method to sort by ascending if the button was hit
    @objc func didTapDec(){
        self.navigationItem.setRightBarButton(self.ascSortButton, animated: false)
        fetchData(sortString: "asc")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        if let layout = WinnersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = self.WinnersCollectionView.frame.width * 0.05
        
        fetchData(sortString: sort)
    }
    }
    
    //Search bar methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
        
    }
    //If search bar was hit, the fetchSearchData function is called with the users requested search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
        let predicate = searchBar.text!
        fetchSearchData(searchString: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count == 0{
            isSearching = false;
        }else{
        isSearching = true;
            
        }
        
    }
    
    //Function that retrieves relevent stocks based off the users search request
    func fetchSearchData(searchString : String) {
        // 0. Start activity indicator animation
        // 2. Send search data request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/stock/search" // localhost:5001/api/tests"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(String(searchString), forHTTPHeaderField: "search")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            guard let data = data else { return }
            
            do {
                // Decode JSON
                let marketplace = try JSONDecoder().decode([SearchResponse].self, from: data)
                // Populate portfolio items from JSON
                var items = [MSMarketPlaceItem]()
                for marketStock in marketplace {
                    let item = MSMarketPlaceItem()
                    item.symbol = marketStock.symbol
                    item.percent = Double(truncating: marketStock.changePercent as NSNumber)
                    item.imageName = marketStock.logo
                    item.price = Double(truncating: marketStock.price as NSNumber)
                    items.append(item)
                }
                let marketPlaceSingleton = MSMarketPlaceData.sharedInstance
                marketPlaceSingleton.items.removeAll()
                marketPlaceSingleton.items.append(contentsOf: items)
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                let indexSet = IndexSet(integer: 3)
                self?.WinnersCollectionView.reloadSections(indexSet)
            }
            }.resume() // fires the session
    }
    
    
    //Function that retrieves all the marketplace view stocks based off the requested sort
    func fetchData(sortString : String) {
        let urlString = "https://mockstock.azurewebsites.net/api/stock/marketplace" // localhost:5001/api/tests"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(String(sortString), forHTTPHeaderField: "sort")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            guard let data = data else { return }
            
            do {
                // Decode JSON
                let marketplace = try JSONDecoder().decode(MarketResponse.self, from: data)
                // Populate Marketplace items from JSON
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
                self?.testCollectionView.setup()
                self?.losersCollectionView.setup()
            }
            }.resume() // fires the session
    }
    
}

extension MarketplaceViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //Sets up 4 seperate sections in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    //Sets up the cells in the collection views with the appropriate stock data retrieved from the fetchData methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: winnersId, for: indexPath)as!MSFeaturedItemCell
            cell.backgroundColor = .clear
            cell.categoryLabel.text = "Todays Winners"
            (testCollectionView = cell)
            cell.navController = self.navigationController
            return cell
        } else if indexPath.section == 1{
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: losersId, for: indexPath)as!MSLosersItemCell
            
            cell.backgroundColor = .clear
            cell.categoryLabel.text = "Todays Losers"
            (losersCollectionView = cell)
            cell.navController = self.navigationController
            return cell
            
        } else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "header", for: indexPath)as!Header
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.backgroundColor = .clear
            cell.Label.textAlignment = .center
            return cell
        }
        else{
            let modelItem = MSMarketPlaceData.sharedInstance.items[indexPath.item]
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: marketId, for: indexPath)as!MSMarketPlaceCell
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.backgroundColor = .clear
            cell.tickerLabel.text = modelItem.symbol.uppercased()
            cell.priceValueLabel.text = String(format: "%.02f", modelItem.price)
            cell.layer.cornerRadius = 5.0
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
            
            if let url = URL(string: modelItem.imageName){
            do{
                let data = try Data(contentsOf: url)
                cell.imageView.image = UIImage(data: data)?.resizeImage(targetSize: CGSize(width: 30, height: 30))
                if cell.imageView.image == nil{
                    cell.imageView.image = UIImage(named: "generic")
                }
            }catch let err{
                print(err)
            }
            }
            return cell
        }
    }
    
    //Sets up the number of items in each section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 3{
            return MSMarketPlaceData.sharedInstance.items.count
        }
        else if section == 0{
           return 1
        }
        else{
           return 1
        }
    }
    
    //Sets up the size of the cells in each section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 3{
            return CGSize(width: collectionView.frame.width / 3 * 0.95, height: collectionView.frame.width / 3 * 0.95) // 110, 110
        }
        else if indexPath.section == 2{
            return CGSize(width: 50, height: 50)
        }
        return CGSize(width: collectionView.frame.width , height: 150)
    }
    
    //Sets up what to do when the cells are clicked by the user
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            let modelItem = gainersData.items[indexPath.item]
            if let nav = navigationController {
                let vc = DetailedViewController()
                vc.symbolTitle = modelItem.symbol.uppercased()
                nav.pushViewController(vc, animated: true)
            }
        }
         else if indexPath.section == 3{
            let modelItem = marketPlaceData.items[indexPath.item]
        if let nav = navigationController {
            let vc = DetailedViewController()
            vc.symbolTitle = modelItem.symbol.uppercased()
            nav.pushViewController(vc, animated: true)
        }
        }
        else if indexPath.section == 1{
            let modelItem = losersData.items[indexPath.item]
            if let nav = navigationController {
                let vc = DetailedViewController()
                vc.symbolTitle = modelItem.symbol.uppercased()
                nav.pushViewController(vc, animated: true)
            }
        }
        else if indexPath.section == 2{
            print("section 2")
        }
    }
    
    //Sets up the spacing of the cells in each section
    func collectionView(_ CollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        if section == 2{
            let totalCellWidth = 80 * CollectionView.numberOfItems(inSection: 2)
            let totalSpacingWidth = 10 * (CollectionView.numberOfItems(inSection:2) - 1)
            let leftInset = (CollectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            return UIEdgeInsets(top: 20, left: leftInset-50, bottom: 0, right: rightInset)
            
        }
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

//Title cell for the IEX stocks
class Header: UICollectionViewCell{
    var Label: UILabel = {
        let l = UILabel(frame: CGRect(x: 200, y: 200, width: 0, height: 0))
        l.text = "IEX Stocks"
        l.textColor = .black
        l.font = UIFont(name: "Helvetica", size: 30)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderViews()
    }
    func setupHeaderViews(){
        addSubview(Label)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("blah blah")
    }
}



    
