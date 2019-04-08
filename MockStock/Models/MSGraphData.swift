//
//  MSGraphData.swift
//  MockStock
//
//  Created by Luke Orr on 4/7/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

class MSMarketGraphData {
    var dates = [MSGraphItemDate]()
    var prices = [MSGraphItemPrice]()
    
    static let sharedInstance = MSMarketGraphData()
    private init() { }
}
