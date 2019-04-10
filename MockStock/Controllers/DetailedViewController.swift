import Foundation
import UIKit

class DetailedViewController: UIViewController {
    
    // Tab bar widgets
    var dateData = MSMarketGraphData.sharedInstance.dates
    var priceData = MSMarketGraphData.sharedInstance.prices
    var vc = GraphViewController()
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
        b.text=("Year Change: 10%")
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
        
        viewControllers.append(vc)
        //Appending buttons to array
        barButtons.append(oneMonth)
        barButtons.append(threeMonth)
        barButtons.append(sixMonth)
        barButtons.append(oneYear)
        currentlySelectedButton = oneMonth
        
        // Add views to screen
        
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
        view.addSubview(graphView)
        self.addChild(viewControllers[0])
        
        setupLayout()
        fetchData()
        fetchGraphData(range: "1M")
        
        // Add button touch handlers
        buyButton.addTarget(self, action: #selector(self.buyPressed), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(self.sellPressed), for: .touchUpInside)
        oneMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        threeMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        sixMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        oneYear.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
    }
    @objc func barButtonPressed(button: UIButton) {
        // Dont press if already selected.
        if button == currentlySelectedButton { return }
        
        // Flag new button as selected.
        currentlySelectedButton = button
        
        // Change graph based on selection (use buttonText to determine the selection. E.g. 3M, 6M, etc.)
        guard let buttonText = button.currentTitle else { return }
        fetchGraphData(range: buttonText)
        // Change tab bar button colors.
        for btn in barButtons {
            if btn == button {
                btn.setTitleColor(.black, for: .normal)
            } else {
                btn.setTitleColor(.gray, for: .normal)
            }
        }
        
    }
    //Setup layout
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
        graphView.widthAnchor.constraint(equalToConstant: 370).isActive = true
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
    
    
    //Fetches detailed view data
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
                let priceString = "Price: $"
                let percentString = "Weeks Change: "
                let highString = "High: $"
                let lowString = "Low: $"
                let yearString = "Year Change: "
                let percent = "%"
                let x = Double(truncating: details.changePercent as NSNumber)
                let y = Double(round(1000*x)/1000)
                let z = Double(truncating: details.ytdChange as NSNumber)
                let v = Double(round(1000*z)/1000)
                let c = Double(truncating: details.price as NSNumber)
                let b = Double(round(100*c)/100)
                let h = Double(truncating: details.high as NSNumber)
                let j = Double(round(100*h)/100)
                let p = Double(truncating: details.low as NSNumber)
                let n = Double(round(100*p)/100)
                let temppriceLabel = String("\(priceString)\(b)")
                let temppercentLabel = String("\(percentString)\(y)\(percent)")
                let temphighLabel = String("\(highString)\(j)")
                let templowLabel = String("\(lowString)\(n)")
                let tempyearChangeLabel = String("\(yearString)\(v)\(percent)")
                
                DispatchQueue.main.async {
                    
                    self.priceLabel.text = temppriceLabel
                    self.percentLabel.text = temppercentLabel
                    self.highLabel.text = temphighLabel
                    self.lowLabel.text = templowLabel
                    self.yearChangeLabel.text = tempyearChangeLabel
                }
            } catch let jsonErr {
                print(jsonErr)
            }
            
            }.resume() // fires the session
    }
    

    //Message that lets user know if transaction is complete
    @objc func marketResponseRecieved(message: String) {
        let alert = UIAlertController(title: "Transaction Complete!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    //Fetches graph data based off which button was seletected
    func fetchGraphData(range: String) {
        let urlString = "https://mockstock.azurewebsites.net/api/stock/chart"
        guard let url = URL(string: urlString) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue(symbolTitle, forHTTPHeaderField: "symbol")
        urlRequest.addValue(range, forHTTPHeaderField: "range")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let e = error { print(e) }
            guard let d = data else { return }
            
            do {
                // Decode JSON
                let graph = try JSONDecoder().decode([ChartResponse].self, from: d)
                var dates = [MSGraphItemDate]()
                var prices = [MSGraphItemPrice]()
                for graphs in graph{
                    let date = MSGraphItemDate()
                    let price = MSGraphItemPrice()
                    price.closingPrice = Double(truncating: graphs.closingPrice as NSNumber)
                    date.date = graphs.date
                    dates.append(date)
                    prices.append(price)
                }
                let graphSingleton = MSMarketGraphData.sharedInstance
                graphSingleton.prices.removeAll()
                graphSingleton.dates.removeAll()
                graphSingleton.prices.append(contentsOf: prices)
                graphSingleton.dates.append(contentsOf: dates)
                
                
                DispatchQueue.main.async {
                    for v in self.graphView.subviews{
                        v.removeFromSuperview()
                    }
                    self.vc = GraphViewController()
                    self.vc.setupChartData(graphDates: dates, graphPrice: prices)
                    self.graphView.insertSubview(self.vc.view, aboveSubview:self.graphView)
                    self.graphView.layoutIfNeeded()
                    
                    
                }
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
            }.resume() // fires the session
    }
}

