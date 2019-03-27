//
//  MSDetailedData.swift
//  MockStock
//
//  Created by Luke Orr on 3/27/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

class MSMarketPlaceData {
    var buyingPower = 0.0
    var items = [MSmarketPlaceItem]()
    
    static let sharedInstance = MSmarketPlaceItem()
    private init() { }
}

