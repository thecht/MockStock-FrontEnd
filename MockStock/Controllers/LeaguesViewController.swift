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
        self.navigationController?.navigationBar.topItem?.title = "Leagues"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newLeagueButtonPressed))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: networkActivityIndicator)
        
        networkActivityIndicator.startAnimating()
        //Add subviews
//        view.addSubview(headerLabel)
//        view.addSubview(divider)
        view.addSubview(collectionView)
//        view.addSubview(addLeagueButton)
        view.addSubview(networkActivityIndicator)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MSLeagueCell.self, forCellWithReuseIdentifier: "LeagueCell")
        
        // Add constraints to the header views
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        addLeagueButton.addTarget(self, action: #selector(newLeagueButtonPressed), for: .touchUpInside)
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
    }
    func fetchData() {
        // 0. Start activity indicator animation
        networkActivityIndicator.startAnimating()
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send portfolio data request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/leagues"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
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
                let leagues = try JSONDecoder().decode([League].self, from: data)
                
                // Populate leagues from JSON
                self?.leagueData = leagues
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.networkActivityIndicator.stopAnimating()
            }
        }.resume() // fires the session
    }
    
    @objc func newLeagueButtonPressed() {
        let alert = UIAlertController(title: "Add League", message: "Join or create new league?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Create League", style: .default, handler: { [weak self] (alert) in
            self?.createLeaugePressed()
        }))
        alert.addAction(UIAlertAction(title: "Join League", style: .default, handler: { [weak self] (alert) in
            self?.joinLeaguePressed()
        }))
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        
        present(alert, animated: true)
        
    }
    
    func createLeaugePressed() {
        let alert = UIAlertController(title: "Create League", message: "Enter New League Name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {(action) in
            if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                self.createLeagueRequest(leagueName: alertTextField.text!)
            }
        }))
        present(alert, animated: true)
    }
    
    func joinLeaguePressed() {
        let alert = UIAlertController(title: "Join League", message: "Enter League Code", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: {(action) in
            if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                self.joinLeagueRequest(leagueCode: alertTextField.text!)
            }
        }))
        present(alert, animated: true)
    }
    
    func createLeagueRequest(leagueName: String) {
        // 0. Start activity indicator animation
        networkActivityIndicator.startAnimating()
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send create league request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/leagues/createleague"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(leagueName, forHTTPHeaderField: "leagueName")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            DispatchQueue.main.async {
                self?.networkActivityIndicator.stopAnimating()
                self?.fetchData()
            }
        }.resume() // fires the session
    }
    
    func joinLeagueRequest(leagueCode: String) {
        // 0. Start activity indicator animation
        networkActivityIndicator.startAnimating()
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send create league request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/leagues/join/\(leagueCode)"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error { print(e) }
            DispatchQueue.main.async {
                self?.networkActivityIndicator.stopAnimating()
                self?.fetchData()
            }
        }.resume() // fires the session
    }
}

extension LeaguesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagueData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelItem = leagueData[indexPath.item]
        
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCell", for: indexPath) as! MSLeagueCell
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .gray
        c.leagueCode.text = "Code: \(modelItem.LeagueId)"
        c.leagueName.text = modelItem.LeagueName
        c.layer.borderWidth = 5.0
        c.layer.borderColor = UIColor.darkGray.cgColor
        
        return c
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 60, height: collectionView.frame.width * 0.24)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelItem = leagueData[indexPath.item]

        if let nav = navigationController {
            let vc = LeagueDetailsViewController()
            vc.leagueName = modelItem.LeagueName
            vc.leagueId = modelItem.LeagueId
            vc.hostId = modelItem.LeagueHost
            print(vc.leagueName)
            nav.pushViewController(vc, animated: true)
        }
    }

}
