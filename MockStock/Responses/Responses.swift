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
