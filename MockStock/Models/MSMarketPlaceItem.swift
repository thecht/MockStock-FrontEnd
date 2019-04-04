//
//  MSMarketPlaceItem.swift
//  MockStock
//
//  Created by Luke Orr on 3/27/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSMarketPlaceItem{
    var symbol = ""
    var price = 0.0
    var imageName = ""
    var percent = 0.0
    
}





class MarketPlaceCategory: NSObject {
    var name: String?
    var stocks: [stock]?
    
    static func sampleStockCategories() -> [MarketPlaceCategory]{
    
        let winnersCategory = MarketPlaceCategory()
        winnersCategory.name = "Todays Winners"
    
        var stocks = [stock]()
        
        let appleStock = stock()
        appleStock.tickerSymbol = "AAPL"
        appleStock.imageName = "AAPL"
        appleStock.price = NSNumber(value: 200.00)
        appleStock.percent = NSNumber(value: 2.12)
        stocks.append(appleStock)
        
        winnersCategory.stocks = stocks
        
        
        
        let losersCategory = MarketPlaceCategory()
        losersCategory.name = "Todays Losers"
        
        var losersApps = [stock]()
        
        let microsoftStock = stock()
        microsoftStock.tickerSymbol = "MSFT"
        microsoftStock.imageName = "MSFT"
        microsoftStock.price = NSNumber(value: 50.00)
        microsoftStock.percent = NSNumber(value: -5.12)
        losersApps.append(microsoftStock)
        
        losersCategory.stocks = losersApps
        
        
        return [winnersCategory, losersCategory]
}
}

class stock: NSObject{
    var id: NSNumber?
    var tickerSymbol: String?
    var price: NSNumber?
    var imageName: String?
    var percent: NSNumber?
}
