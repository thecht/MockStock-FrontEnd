//
//  LeaguesViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class LeaguesViewController: UIViewController {
    
    // Fields
    var leagueData = [League]()
    
    // Views
    var headerLabel: UILabel = {
        let l = UILabel()
        l.text = "Leagues"
        l.font = UIFont(name: "Futura-CondensedExtraBold", size: 48)
        l.textColor = UIColor.black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    var networkActivityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.style = .gray
        return v
    }()
    var addLeagueButton: UIButton = {
        let b = UIButton()
        b.setBackgroundImage(UIImage(named:"add"), for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    var divider: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
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
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        
        //Add subviews
        view.addSubview(headerLabel)
        view.addSubview(divider)
        view.addSubview(collectionView)
        view.addSubview(addLeagueButton)
        view.addSubview(networkActivityIndicator)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MSLeagueCell.self, forCellWithReuseIdentifier: "LeagueCell")
        
        // Add constraints to the header views
        let leftInset = CGFloat(30.0)
        let rightInset = CGFloat(-30.0)
        let topInset = CGFloat(30.0)
        
        headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topInset).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: leftInset).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addLeagueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: rightInset).isActive = true
        addLeagueButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor, constant: 0).isActive = true
        addLeagueButton.heightAnchor.constraint(equalTo: headerLabel.heightAnchor, multiplier: 0.5).isActive = true
        addLeagueButton.widthAnchor.constraint(equalTo: headerLabel.heightAnchor, multiplier: 0.5).isActive = true
        
        networkActivityIndicator.trailingAnchor.constraint(equalTo: addLeagueButton.leadingAnchor, constant: -15).isActive = true
        networkActivityIndicator.centerYAnchor.constraint(equalTo: addLeagueButton.centerYAnchor, constant: 0).isActive = true
        
        divider.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20).isActive = true
        divider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.layoutIfNeeded()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = UIEdgeInsets(top: 35, left: 0, bottom: 45, right: 0)
            layout.minimumInteritemSpacing = 15
            layout.minimumLineSpacing = 15
        }
        
        fetchData()
        print("League View Appeared")
    }
    func fetchData() {
        
    }
    
}

extension LeaguesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 //leagueData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let modelItem = leagueData[indexPath.item]
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCell", for: indexPath) as! MSLeagueCell
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .gray
        
        c.layer.borderWidth = 5.0
        c.layer.borderColor = UIColor.darkGray.cgColor
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.width * 0.24)
    }
}
