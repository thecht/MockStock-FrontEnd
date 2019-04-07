import Foundation
import UIKit

class DetailedViewController: UIViewController {
    
    // Tab bar widgets
    var graphView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        return v
    }()
    var backButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("<  back", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    var buyButton: UIButton = {
        let b = UIButton()
        b.setTitle("   Buy    ", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(red: 87, green: 210, blue: 2)
        b.layer.borderWidth = 2.0
        b.layer.cornerRadius = 5.0
        b.clipsToBounds = true
        b.layer.borderColor = UIColor(red: 70, green: 166, blue: 1).cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        // b.frame = CGRect(x: 200, y: 200, width: 100, height: 25)
        return b
    }()
    var sellButton: UIButton = {
        let b = UIButton()
        b.setTitle("    Sell    ", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(red: 87, green: 210, blue: 2)
        b.layer.borderWidth = 2.0
        b.layer.cornerRadius = 5.0
        b.clipsToBounds = true
        b.layer.borderColor = UIColor(red: 70, green: 166, blue: 1).cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        // b.frame = CGRect(x: 250, y: 200, width: 100, height: 25)
        return b
    }()
    var oneMonth: UIButton = {
        let b = UIButton()
        b.setTitle("1M", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 0
        return b
    }()
    var threeMonth: UIButton = {
        let b = UIButton()
        b.setTitle("3M", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.gray, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 1
        return b
    }()
    var sixMonth: UIButton = {
        let b = UIButton()
        b.setTitle("6M", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.gray, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 2
        return b
    }()
    var oneYear: UIButton = {
        let b = UIButton()
        b.setTitle("1Y", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.gray, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 3
        return b
    }()
    
    var symbolLabel: UILabel = {
        let b = UILabel()
        b.text=("APPL")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-CondensedExtraBold", size: 40)
        b.translatesAutoresizingMaskIntoConstraints = false
        //b.textAlignment = .left
        return b
    }()
    
    var priceLabel: UILabel = {
        let b = UILabel()
        b.text=("Price: $550")
        b.textColor = UIColor.gray
        b.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        //b.textAlignment = .left
        return b
    }()
    
    var percentLabel: UILabel = {
        let b = UILabel()
        b.text=("Weeks Change: 2%")
        b.textColor = UIColor.gray
        b.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .center
        return b
    }()
    
    var highLabel: UILabel = {
        let b = UILabel()
        b.text=("High: $550")
        b.textColor = UIColor.gray
        b.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .left
        return b
    }()
    
    var lowLabel: UILabel = {
        let b = UILabel()
        b.text=("Low: $500")
        b.textColor = UIColor.gray
        b.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .left
        return b
    }()
    
    var yearChangeLabel: UILabel = {
        let b = UILabel()
        b.text=("Year Change: 10$")
        b.textColor = UIColor.gray
        b.font = UIFont(name: "HelveticaNeue-Thin", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .center
        return b
    }()
    
    var barButtons = [UIButton]()
    var viewControllers = [UIViewController]()
    var currentlySelectedButton: UIButton!
    var symbolTitle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = symbolTitle
        self.navigationController?.navigationBar.barTintColor = .white
        
        viewControllers.append(GraphViewController())
        //Appending buttons to array
        barButtons.append(oneMonth)
        barButtons.append(threeMonth)
        barButtons.append(sixMonth)
        barButtons.append(oneYear)
        currentlySelectedButton = oneMonth
        
        // Add views to screen
        view.addSubview(graphView)
        view.addSubview(oneMonth)
        view.addSubview(threeMonth)
        view.addSubview(sixMonth)
        view.addSubview(oneYear)
        view.addSubview(buyButton)
        view.addSubview(sellButton)
        view.addSubview(priceLabel)
        view.addSubview(percentLabel)
        view.addSubview(highLabel)
        view.addSubview(lowLabel)
        view.addSubview(yearChangeLabel)
        
        self.addChild(viewControllers[0])
        graphView.insertSubview(viewControllers[0].view, aboveSubview:graphView)
        
        setupLayout()
        print(symbolLabel.text)
        fetchData()
        // Add button touch handlers
        buyButton.addTarget(self, action: #selector(self.buyPressed), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(self.sellPressed), for: .touchUpInside)
        oneMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        threeMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        sixMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        oneYear.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
    }
    
    func setupLayout(){
        priceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        highLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        highLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        highLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        highLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 10).isActive = true
        lowLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        lowLabel.widthAnchor.constraint(equalToConstant: 170).isActive = true
        lowLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        buyButton.centerYAnchor.constraint(equalTo: highLabel.centerYAnchor, constant: 0).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: sellButton.leadingAnchor, constant: -10).isActive = true
        buyButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sellButton.centerYAnchor.constraint(equalTo: highLabel.centerYAnchor, constant: 0).isActive = true
        sellButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        sellButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sellButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        graphView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        graphView.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 80).isActive = true
        graphView.widthAnchor.constraint(equalToConstant: 365).isActive = true
        graphView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        oneMonth.leadingAnchor.constraint(equalTo: graphView.leadingAnchor).isActive = true
        oneMonth.trailingAnchor.constraint(equalTo: threeMonth.leadingAnchor).isActive = true
        oneMonth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        oneMonth.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 0).isActive = true
        oneMonth.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.25).isActive = true
        
        threeMonth.leadingAnchor.constraint(equalTo: oneMonth.trailingAnchor).isActive = true
        threeMonth.trailingAnchor.constraint(equalTo: sixMonth.leadingAnchor).isActive = true
        threeMonth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        threeMonth.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 0).isActive = true
        threeMonth.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.25).isActive = true
        
        sixMonth.leadingAnchor.constraint(equalTo: threeMonth.trailingAnchor).isActive = true
        sixMonth.trailingAnchor.constraint(equalTo: oneYear.leadingAnchor).isActive = true
        sixMonth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sixMonth.topAnchor.constraint(equalTo: graphView.bottomAnchor).isActive = true
        sixMonth.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.25).isActive = true
        
        oneYear.leadingAnchor.constraint(equalTo: sixMonth.trailingAnchor).isActive = true
        oneYear.trailingAnchor.constraint(equalTo: graphView.trailingAnchor).isActive = true
        oneYear.heightAnchor.constraint(equalToConstant: 50).isActive = true
        oneYear.topAnchor.constraint(equalTo: graphView.bottomAnchor).isActive = true
        oneYear.widthAnchor.constraint(equalTo: graphView.widthAnchor, multiplier: 0.25).isActive = true
        
        percentLabel.topAnchor.constraint(equalTo: oneYear.bottomAnchor, constant: 20).isActive = true
        percentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        percentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        percentLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        yearChangeLabel.topAnchor.constraint(equalTo: oneYear.bottomAnchor, constant: 20).isActive = true
        yearChangeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        yearChangeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        yearChangeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func buyPressed() {
        let alert = UIAlertController(title: "Buy Stock", message: "How much do you want?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Buy", style: .default, handler: {(action) in
            if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                self.buyStockRequest(quantity: alertTextField.text!)
            }
        }))
        present(alert, animated: true)
    }
    
    @objc func sellPressed() {
        let alert = UIAlertController(title: "Sell Stock", message: "How much do you want to sell?", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sell", style: .default, handler: {(action) in
            if let alertTextField = alert.textFields?.first, alertTextField.text != nil {
                self.sellStockRequest(quantity: alertTextField.text!)
            }
        }))
        present(alert, animated: true)
    }
    
    func buyStockRequest(quantity: String) {
        // 0. Start activity indicator animation
        //networkActivityIndicator.startAnimating()
        guard let buyQuantity = Int(quantity) else { return }
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send leave league request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/stock/buy"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(String(buyQuantity), forHTTPHeaderField: "amount")
        urlRequest.addValue(symbolTitle, forHTTPHeaderField: "symbol")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let e = error { print(e) }
            guard let d = data else { return }
            
            do {
                // Decode JSON
                let buyResponse = try JSONDecoder().decode(BuySellResponse.self, from: d)
                
                let message = "You bought \(buyResponse.StockQty) shares of \(buyResponse.StockId)"
                DispatchQueue.main.async {
                    self.marketResponseRecieved(message: message)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            
            }.resume() // fires the session
        
    }
    
    func sellStockRequest(quantity: String) {
        // 0. Start activity indicator animation
        //networkActivityIndicator.startAnimating()
        guard let buyQuantity = Int(quantity) else { return }
        
        // 1. Get valid token
        guard let token = UserDefaults.standard.string(forKey: "Token") else {
            MSRestMock.fetchAuthenticationToken(callback: fetchData)
            return
        }
        
        // 2. Send leave league request to server using authentication token
        let urlString = "https://mockstock.azurewebsites.net/api/stock/sell"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        urlRequest.addValue(String(buyQuantity), forHTTPHeaderField: "amount")
        urlRequest.addValue(symbolTitle, forHTTPHeaderField: "symbol")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let d = data else { return }
            
            do {
                // Decode JSON
                let buyResponse = try JSONDecoder().decode(BuySellResponse.self, from: d)
                
                let message = "You sold \(buyResponse.StockQty) shares of \(buyResponse.StockId)"
                DispatchQueue.main.async {
                    self.marketResponseRecieved(message: message)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            
            }.resume() // fires the session
        // Then, submit sell network request
    }
    
    @objc func barButtonPressed(button: UIButton) {
        // Dont press if already selected.
        if button == currentlySelectedButton { return }
        
        // Flag new button as selected.
        currentlySelectedButton = button
        
        // Change graph based on selection (use buttonText to determine the selection. E.g. 3M, 6M, etc.)
        guard let buttonText = button.currentTitle else { return }
        
        // Change tab bar button colors.
        for btn in barButtons {
            if btn == button {
                btn.setTitleColor(.black, for: .normal)
            } else {
                btn.setTitleColor(.gray, for: .normal)
            }
        }
        
    }
    
    func fetchData() {
        let urlString = "https://mockstock.azurewebsites.net/api/stock/details"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(symbolTitle, forHTTPHeaderField: "symbol")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let e = error { print(e) }
            guard let d = data else { return }
            
            do {
                // Decode JSON
                let details = try JSONDecoder().decode(DetailedResponse.self, from: d)
                let priceString = "Price: "
                let percentString = "Weeks Change: "
                let highString = "High: "
                let lowString = "Low: "
                let yearString = "Year Change: "
                let percent = "%"
                self.priceLabel.text = String("\(priceString)\(details.price)")
                self.percentLabel.text = String("\(percentString)\(details.changePercent)\(percent)")
                self.highLabel.text = String("\(highString)\(details.high)")
                self.lowLabel.text = String("\(lowString)\(details.high)")
                self.yearChangeLabel.text = String("\(yearString)\(details.ytdChange)\(percent)")
                
                
                DispatchQueue.main.async {
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            
            }.resume() // fires the session
    }
    
    @objc func marketResponseRecieved(message: String) {
        let alert = UIAlertController(title: "Transaction Complete!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
