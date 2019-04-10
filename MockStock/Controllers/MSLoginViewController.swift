//
//  LoginViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/19/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

class MSLoginViewController: UIViewController, UITextFieldDelegate {
    
    var welcomeLabel: UILabel = {
        var l = UILabel()
        l.text = "MOCK STOCK"
        l.textColor = .black
        l.textAlignment = .center
        l.font = UIFont(name: "Futura-CondensedExtraBold", size: 44)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    var networkActivityIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.hidesWhenStopped = true
        v.style = .gray
        return v
    }()
    var loginBackground: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.05)
        return v
    }()
    var loginField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .none
        textfield.placeholder = "Username"
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
        return textfield
    }()
    var passwordBackground: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(displayP3Red: 0.1, green: 0.1, blue: 0.1, alpha: 0.05)
        return v
    }()
    var passwordField: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.borderStyle = .none
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.spellCheckingType = .no
        return textfield
    }()
    var loginButton: UIButton = {
        let b = UIButton()
        b.setTitle("LOGIN", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.contentHorizontalAlignment = .center
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    var registerButton: UIButton = {
        let b = UIButton()
        b.setTitle("REGISTER", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.contentHorizontalAlignment = .center
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        b.layer.borderWidth = 2.0
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.white
        
        // Add views to container
        view.addSubview(welcomeLabel)
        view.addSubview(networkActivityIndicator)
        view.addSubview(loginBackground)
        view.addSubview(loginField)
        view.addSubview(passwordBackground)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        // Setup Constraints
        setupConstraints()
        
        // Add button handlers
        loginButton.addTarget(self, action: #selector(MSLoginViewController.loginClicked), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(MSLoginViewController.registerClicked), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing)))
        loginField.delegate = self
        passwordField.delegate = self
    }
    
    func setupConstraints() {
        welcomeLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        
        networkActivityIndicator.bottomAnchor.constraint(equalTo: loginBackground.topAnchor, constant: -15).isActive = true
        networkActivityIndicator.widthAnchor.constraint(equalToConstant: 25).isActive = true
        networkActivityIndicator.heightAnchor.constraint(equalToConstant: 25).isActive = true
        networkActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        loginBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginBackground.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 50).isActive = true
        loginBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        loginField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        loginField.topAnchor.constraint(equalTo: loginBackground.topAnchor, constant: 0).isActive = true
        loginField.bottomAnchor.constraint(equalTo: loginBackground.bottomAnchor, constant: 0).isActive = true
        
        passwordBackground.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        passwordBackground.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        passwordBackground.topAnchor.constraint(equalTo: loginBackground.bottomAnchor, constant: 20).isActive = true
        passwordBackground.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        passwordField.topAnchor.constraint(equalTo: passwordBackground.topAnchor, constant: 0).isActive = true
        passwordField.bottomAnchor.constraint(equalTo: passwordBackground.bottomAnchor, constant: 0).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20).isActive = true
        
        registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Round corners
        loginBackground.layer.cornerRadius = loginBackground.frame.height/12
        passwordBackground.layer.cornerRadius = passwordBackground.frame.height/12
        loginButton.layer.cornerRadius = loginButton.frame.height/12
        registerButton.layer.cornerRadius = registerButton.frame.height/12
        
        // Set default if exists
        if let username = UserDefaults.standard.object(forKey: "UserName") as! String? {
            loginField.text = username
        }
        if let password = UserDefaults.standard.object(forKey: "Password") as! String? {
            passwordField.text = password
        }
        UserDefaults.standard.set("", forKey: "Token")
        
    }
    
    @objc func loginClicked() {
        guard let usernameText = loginField.text else { return }
        guard let passwordText = passwordField.text else { return }
        if usernameText.isEmpty || passwordText.isEmpty {
            // set error message
            print("Cannot be empty.")
            return
        }
        let trimmedUsernameText = removeCharacters(string: usernameText, characterSet: [.whitespaces, .illegalCharacters, .controlCharacters, .newlines, .punctuationCharacters, .symbols])
        let trimmedPasswordText = removeCharacters(string: passwordText, characterSet: [.whitespaces, .illegalCharacters, .controlCharacters, .newlines, .punctuationCharacters, .symbols])
        if usernameText != trimmedUsernameText || passwordText != trimmedPasswordText {
            print("Invalid username or password text.")
            return
        }
        UserDefaults.standard.removeObject(forKey: "Token")
        networkActivityIndicator.startAnimating()
        let urlString = "https://mockstock.azurewebsites.net/api/users/token"
        guard let url = URL(string: urlString) else {
            self.view.isUserInteractionEnabled = true
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(trimmedUsernameText, forHTTPHeaderField: "username")
        urlRequest.addValue(trimmedPasswordText, forHTTPHeaderField: "password")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error {
                print(e)
                return
            }
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8) ?? "")
            do {
                let tokenData = try JSONDecoder().decode(TokenResponse.self, from: data)
                UserDefaults.standard.set(tokenData.userId, forKey: "UserId")
                UserDefaults.standard.set(trimmedUsernameText, forKey: "UserName")
                UserDefaults.standard.set(trimmedPasswordText, forKey: "Password")
                UserDefaults.standard.set("Bearer \(tokenData.token)", forKey: "Token")
                DispatchQueue.main.async {
                    self?.networkActivityIndicator.stopAnimating()
                    self?.showMainApp()
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                self?.networkActivityIndicator.stopAnimating()
            }
        }.resume() // fires the session
    }
    
    @objc func registerClicked() {
        guard let usernameText = loginField.text else { return }
        guard let passwordText = passwordField.text else { return }
        if usernameText.isEmpty || passwordText.isEmpty {
            // set error message
            print("Cannot be empty.")
            return
        }
        let trimmedUsernameText = removeCharacters(string: usernameText, characterSet: [.whitespaces, .illegalCharacters, .controlCharacters, .newlines, .punctuationCharacters, .symbols])
        let trimmedPasswordText = removeCharacters(string: passwordText, characterSet: [.whitespaces, .illegalCharacters, .controlCharacters, .newlines, .punctuationCharacters, .symbols])
        if usernameText != trimmedUsernameText || passwordText != trimmedPasswordText {
            print("Invalid username or password text.")
            return
        }
        UserDefaults.standard.removeObject(forKey: "Token")
        networkActivityIndicator.startAnimating()
        
        let urlString = "https://mockstock.azurewebsites.net/api/users"
        guard let url = URL(string: urlString) else {
            self.view.isUserInteractionEnabled = true
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(trimmedUsernameText, forHTTPHeaderField: "username")
        urlRequest.addValue(trimmedPasswordText, forHTTPHeaderField: "password")
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            if let e = error {
                print(e)
                return
            }
            guard let data = data else { return }
            do {
                let registrationData = try JSONDecoder().decode(RegistrationResponse.self, from: data)
                UserDefaults.standard.set(registrationData.UserId, forKey: "UserId")
                UserDefaults.standard.set(registrationData.UserName, forKey: "UserName")
                UserDefaults.standard.set(trimmedPasswordText, forKey: "Password")
                UserDefaults.standard.set("", forKey: "Token")
                DispatchQueue.main.async {
                    self?.networkActivityIndicator.stopAnimating()
                    self?.showMainApp()
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            DispatchQueue.main.async {
                self?.networkActivityIndicator.stopAnimating()
            }
        }.resume() // fires the session
    }
    
    
    func loginResponse(data: Data) {
        networkActivityIndicator.stopAnimating()
    }
    func registrationResponse() {
        
    }
    func removeCharacters(string: String, characterSet: [CharacterSet]) -> String {
        var retVal = string
        for set in characterSet {
            let stringComponents = retVal.components(separatedBy: set)
            let trimmedString = stringComponents.joined(separator: "")
            retVal = trimmedString
        }
        return retVal
    }
    
    func showMainApp() {
        guard let appdelegate = UIApplication.shared.delegate else { return }
        guard let window = appdelegate.window else { return }
        
        let tabBarViewController = MSTabBarViewController()
        removeFromParent()
        window!.rootViewController = tabBarViewController
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
