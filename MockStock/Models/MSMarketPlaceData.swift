//
//  MSMarketPlaceData.swift
//  MockStock
//
//  Created by Luke Orr on 4/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

class MSMarketPlaceData {
    var items = [MSMarketPlaceItem]()
    
    static let sharedInstance = MSMarketPlaceData()
    private init() { }
}
class MSWinnersData {
    var items = [MSMarketPlaceItem]()
    
    static let sharedInstance = MSWinnersData()
    private init() { }
}
class MSLosersData {
    var items = [MSMarketPlaceItem]()
    
    static let sharedInstance = MSLosersData()
    private init() { }
}
