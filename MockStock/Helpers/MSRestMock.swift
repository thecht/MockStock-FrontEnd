//
//  MSRestMock.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/18/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

class MSRestMock {
    
    static func fetchPortfolioData() {
        let item = MSPortfolioItem()
        item.percentChange = 0.03
        item.symbol = "APPL"
        item.quantity = 42
        item.price = 45.00
        
        let data = MSPortfolioData.sharedInstance
        data.buyingPower = 45000.00
        data.portfolioValue = 13000.00
        data.items.append(item)
        data.items.append(item)
        data.items.append(item)
    }
}
