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
    var UserCurrency: Decimal
}

struct TokenResponse: Decodable {
    var userId: Int
    var token: String
}
