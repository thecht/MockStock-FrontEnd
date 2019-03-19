//
//  LoginViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/19/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSLoginViewController: UIViewController {
    var logo: UIImageView = {
        let i = UIImageView(image: UIImage(named: "mockstocklogo"))
        //i.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    var welcomeLabel: UILabel = {
        var l = UILabel()
        l.text = "Login or Register"
        l.textAlignment = .center
        l.font = UIFont(name: "Futura", size: 22)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    var loginField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Username"
        return textfield
    }()
    var passwordLabel: UILabel = {
        var l = UILabel()
        l.text = "Password"
        return l
    }()
    var passwordField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
        return textfield
    }()
    
    var loginButton: UIButton = {
        let b = UIButton()
        b.setTitle("LOGIN", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.contentHorizontalAlignment = .right
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    var registerButton: UIButton = {
        let b = UIButton()
        b.setTitle("REGISTER", for: .normal)
        b.setTitleColor(.blue, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override func viewDidLoad() {
        print("login loaded")
        self.view.backgroundColor = .white
        /*
         if keychain data exists -> show splash screen & fetch data & pass control back to app.
         if keychain data doesn't exist -> show login/create user screen
         
         show login screen.
         if keychain data exists -> automatically populate login information
         
         + Username box
         + Password box
         + Create new user button
         
         */
        view.addSubview(logo)
        view.addSubview(welcomeLabel)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        logo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        welcomeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        welcomeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15).isActive = true
        
        loginField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50).isActive = true
        loginField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 25).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        
    }
}
