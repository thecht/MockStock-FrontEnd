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
        data.buyingPower = 0
        data.portfolioValue = 0
        data.items.append(item)
        data.items.append(item)
        data.items.append(item)
    }
    
    static func fetchAuthenticationToken(callback: @escaping ()->Void) {
        let urlString = "https://mockstock.azurewebsites.net/api/users/token"
        guard let username = UserDefaults.standard.string(forKey: "UserName") else { return }
        guard let password = UserDefaults.standard.string(forKey: "Password") else { return }
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(username, forHTTPHeaderField: "username")
        urlRequest.addValue(password, forHTTPHeaderField: "password")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let e = error {
                print(e)
                return
            }
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8) ?? "")
            do {
                let tokenData = try JSONDecoder().decode(TokenResponse.self, from: data)
                UserDefaults.standard.set("Bearer \(tokenData.token)", forKey: "Token")
                UserDefaults.standard.set(tokenData.userId, forKey: "UserId")
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                callback()
            }
        }.resume() // fires the session
    }
    
    static func checkUnauthorizedStatusCode(response:URLResponse?) -> Bool {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return false
        }
        
        if statusCode != 401 {
            return false
        }
        return true
    }
}
