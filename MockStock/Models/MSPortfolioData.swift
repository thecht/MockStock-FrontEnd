//
//  MSPortfolioData.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/18/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

class MSPortfolioData {
    var buyingPower = 0.0
    var portfolioValue = 0.0
    var items = [MSPortfolioItem]()
    
    static let sharedInstance = MSPortfolioData()
    private init() { }
}
