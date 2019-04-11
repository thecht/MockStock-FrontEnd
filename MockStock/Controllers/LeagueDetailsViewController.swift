//
//  LeagueDetailsViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 4/1/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class LeagueDetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var leagueUsers = [LeagueUser]()
    var leagueName = "League Name"
    var leagueId: String?
    var hostId: Int?
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    var collectionView: UICollectionView = {
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.backgroundColor = .white
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = leagueName
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(leaveLeaguePressed))
        
        // Add collection view
        view.addSubview(collectionView)
        
        // Add constraints
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        // Button handlers
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MSLeagueUserCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.view.layoutIfNeeded()
        
        fetchData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagueUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get model
        let modelItem = leagueUsers[indexPath.item]
        
        // Configure Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MSLeagueUserCell
        cell.userName.text = modelItem.UserName
        cell.userName.textColor = .black
        cell.netWorth.text = "$" + String(format: "%.02f", modelItem.UserCurrency) //"$\(modelItem.UserCurrency)"
        cell.netWorth.textColor = .black
        cell.setColors(topView: UIColor(red: 229, green: 229, blue: 229), bottomViewColor: UIColor(red: 255, green: 255, blue: 255))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.width * 0.15)
    }
    
    func fetchData() {
        guard let lid = leagueId else { return }
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send portfolio data request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/leagues/leaderboard/\(lid)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        print(urlRequest.debugDescription)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            guard let data = data else { return }
            // Check for expired token
            if MSRestMock.checkUnauthorizedStatusCode(response: response) {
                print("unauthorized: getting token")
                MSRestMock.fetchAuthenticationToken(callback: self!.fetchData)
            }
            
            do {
                // Decode JSON
                let leaderboard = try JSONDecoder().decode([LeagueUser].self, from: data)
                
                // Populate league user items from JSON
                self?.leagueUsers = leaderboard
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }.resume() // fires the session
    }
    
    @objc func leaveLeaguePressed() {
        guard let hid = self.hostId else { return }
        let userid = UserDefaults.standard.integer(forKey: "UserId")
        
        // Configure's alert text
        var alertTitle = "Leave League"
        var alertMessage = "Do you want to leave the league?"
        if userid == hid {
            alertTitle = "Delete League"
            alertMessage = "Do you want to delete the league?"
        }
        
        // Configure alert view
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: {(action) in
            if userid == hid {
                self.deleteLeague()
            } else {
                self.leaveLeague()
            }
        }))
        present(alert, animated: true)
    }
    
    @objc func leaveLeague() {
        // 0. Start activity indicator animation
        //networkActivityIndicator.startAnimating()
        guard let lid = leagueId else { return }
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send leave league request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/leagues/leave/\(lid)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }.resume() // fires the session
    }
    
    func deleteLeague() {
        // 0. Start activity indicator animation
        //networkActivityIndicator.startAnimating()
        guard let lid = leagueId else { return }
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send delete league request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/leagues/deleteLeague"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue(lid, forHTTPHeaderField: "leagueID")
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            print(String(data: data!, encoding: .utf8) ?? "")
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }.resume() // fires the session
    }
    
}

class MSLeagueUserCell: UICollectionViewCell {
    
    // Background bars
    var colorView1: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }()
    var colorView2: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.darkGray
        return v
    }()
    
    // Labels
    var userName: UILabel = {
        let l = UILabel()
        l.text = "Someone"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 24)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    var netWorth: UILabel = {
        let l = UILabel()
        l.text = "$500"
        l.font = UIFont(name: "Futura-CondensedMedium", size: 24)
        l.textColor = .white
        l.textAlignment = .left
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        // Configure view properties
        layer.cornerRadius = self.frame.width / 25
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
//        layer.shadowOpacity = 0.4
//        layer.shadowRadius = 4.0
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 4.0
        clipsToBounds = true
        
        // Add & Configure subviews
        addSubview(colorView1)
        addSubview(colorView2)
        
        addSubview(userName)
        addSubview(netWorth)
        
        netWorth.textAlignment = .right
        
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Size background views
        colorView2.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.5)
        //colorView2.layer.cornerRadius = colorView2.frame.width / 25
        colorView1.frame = CGRect(x: 0, y: frame.height * 0.5, width: frame.width, height: frame.height * 0.5)
        
        setupLabels()
    }
    
    private func setupLabels() {
        userName.frame = CGRect(x: 15, y: frame.height/2 - 20, width: frame.width, height: 40)
        netWorth.frame = CGRect(x: frame.width/2, y: frame.height/2 - 20, width: frame.width/2 - 15, height: 40)
    }
    
    func setColors(topView: UIColor, bottomViewColor: UIColor) {
        self.backgroundColor = topView
        self.colorView1.backgroundColor = topView
        self.colorView2.backgroundColor = bottomViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
