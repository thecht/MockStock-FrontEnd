//
//  RegistrationResponse.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/25/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation

struct RegistrationResponse: Decodable {
    var UserId: Int
    var UserName: String
    var UserCurrency: Double
}

struct TokenResponse: Decodable {
    var userId: Int
    var token: String
}

struct PortfolioResponse: Decodable {
    var UserCurrency: Double
    var Stock: [Stock]
}

struct Stock: Decodable {
    var StockId: String
    var StockQuantity: Int
}

struct LeagueResponse: Decodable {
    var UserId: Int
    var Leagues: [League]
//    var OpenEnrollment: Bool
}

struct League: Decodable {
    var LeagueId: String
    var LeagueName: String
    var LeagueHost: Int
}

struct LeagueUser: Decodable {
    var UserId: Int
    var UserName: String
    var NetWorth: Double
}

struct MarketResponse: Decodable{
        var stocks : [MarketStock]
        var gainers : [MarketStock]
        var losers : [MarketStock]
}

struct MarketStock: Decodable{
    var symbol : String
    var logo : String
    var price : Decimal
    var changePercent : Decimal
}

struct DetailedResponse: Decodable{
    var symbol : String
    var price : Decimal
    var changePercent : Decimal
    var ytdChange : Decimal
    var high : Decimal
    var low : Decimal
}

struct ChartResponse : Decodable{
    var date : String
    var closingPrice : Decimal
    
}
