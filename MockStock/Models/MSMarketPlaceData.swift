//
//  MSMarketPlaceData.swift
//  MockStock
//
//  Created by Luke Orr on 4/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

class MSMarketPlaceData {
    var buyingPower = 0.0
    var items = [MSMarketPlaceItem]()
    
    static let sharedInstance = MSMarketPlaceData()
    private init() { }
}
