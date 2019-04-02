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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(leavueLeague))
        
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
        
        fetchData()
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
        cell.netWorth.text = "$\(modelItem.NetWorth)"
        cell.setColors(topView: .gray, bottomViewColor: .darkGray)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.width * 0.15)
    }
    
    func fetchData() {
        let lu1 = LeagueUser(UserId: 42, UserName: "SomeDude", NetWorth: 411.13)
        let lu2 = LeagueUser(UserId: 421, UserName: "SomeDude2", NetWorth: 2311.13)
        let lu3 = LeagueUser(UserId: 4211, UserName: "SomeDude3", NetWorth: 431.11)
        let lu4 = LeagueUser(UserId: 42123, UserName: "SomeDude4", NetWorth: 3211.12)
        let lu5 = LeagueUser(UserId: 42121, UserName: "SomeDude5", NetWorth: 14211.13)
        let lu6 = LeagueUser(UserId: 4212, UserName: "Another Person", NetWorth: 9000.13)
        leagueUsers = [lu1, lu2, lu3, lu4, lu5, lu6]
    }
    
    @objc func leavueLeague() {
        
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
