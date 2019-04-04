
import Foundation
import UIKit



class DetailedViewController: UIViewController {
    
    // Tab bar widgets
    var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        return v
    }()
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
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 1
        return b
    }()
    var sixMonth: UIButton = {
        let b = UIButton()
        b.setTitle("6M", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.black, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.tag = 2
        return b
    }()
    var oneYear: UIButton = {
        let b = UIButton()
        b.setTitle("1Y", for: .normal)
        b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
        b.setTitleColor(.black, for: .normal)
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
        b.textAlignment = .left
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
        b.textAlignment = .left
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
//        self.navigationController?.navigationBar.barTintColor = .white
        
        viewControllers.append(GraphViewController())
        //Appending buttons to array
        barButtons.append(oneMonth)
        barButtons.append(threeMonth)
        barButtons.append(sixMonth)
        barButtons.append(oneYear)
        
        // Add views to screen
//        view.addSubview(contentView)
        view.addSubview(graphView)
//        contentView.addSubview(oneMonth)
//        contentView.addSubview(threeMonth)
//        contentView.addSubview(sixMonth)
//        contentView.addSubview(oneYear)
        view.addSubview(oneMonth)
        view.addSubview(threeMonth)
        view.addSubview(sixMonth)
        view.addSubview(oneYear)
        view.addSubview(buyButton)
        view.addSubview(sellButton)
//        view.addSubview(symbolLabel)
        view.addSubview(priceLabel)
//        view.addSubview(percentLabel)
        view.addSubview(highLabel)
        view.addSubview(lowLabel)
//        view.addSubview(yearChangeLabel)
//        view.addSubview(backButton)
        
        currentlySelectedButton = oneMonth
        self.addChild(viewControllers[0])
        graphView.insertSubview(viewControllers[0].view, aboveSubview:graphView)
        //view.insertSubview(viewControllers[0].view, belowSubview: contentView)
        // Add autolayout constraints
    setupLayout()
        // Add button touch handlers
        buyButton.addTarget(self, action: #selector(self.addBuyTransactionPopup), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(self.addSellTransactionPopup), for: .touchUpInside)
        oneMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        threeMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        sixMonth.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        oneYear.addTarget(self, action: #selector(DetailedViewController.barButtonPressed(button:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(DetailedViewController.backButtonPressed(button:)), for: .touchUpInside)
    }
    @objc func barButtonPressed(button: UIButton) {
        // Dont press if already selected.
        if button == currentlySelectedButton { return }
        
        // Flag new button as selected.
        currentlySelectedButton = button
        
        // Swap View Controllers.
        for vc in children {
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }
        self.addChild(viewControllers[button.tag])
        view.insertSubview(viewControllers[button.tag].view, belowSubview: contentView)
        
        // Change tab bar button colors.
        for btn in barButtons {
            if btn == button {
                btn.setTitleColor(.black, for: .normal)
            } else {
                btn.setTitleColor(.gray, for: .normal)
            }
        }
        
    }
    
    /*@objc func transactionButtonPressed(button:UIButton){
        let mainVC = transactionView()
        present(mainVC, animated: true, completion: nil)
        
    }
    */
    @objc func backButtonPressed(button:UIButton){
        dismiss(animated: true, completion: nil)
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
        
//        buyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        buyButton.centerYAnchor.constraint(equalTo: highLabel.centerYAnchor, constant: 0).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: sellButton.leadingAnchor, constant: -10).isActive = true
        buyButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
//        sellButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
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
        /*
        graphView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        graphView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        graphView.widthAnchor.constraint(equalToConstant: 365).isActive = true
        graphView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 0).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: 365).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        oneMonth.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        oneMonth.trailingAnchor.constraint(equalTo: threeMonth.leadingAnchor).isActive = true
        oneMonth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        oneMonth.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        oneMonth.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        threeMonth.leadingAnchor.constraint(equalTo: oneMonth.trailingAnchor).isActive = true
        threeMonth.trailingAnchor.constraint(equalTo: sixMonth.leadingAnchor).isActive = true
        threeMonth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        threeMonth.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        threeMonth.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        sixMonth.leadingAnchor.constraint(equalTo: threeMonth.trailingAnchor).isActive = true
        sixMonth.trailingAnchor.constraint(equalTo: oneYear.leadingAnchor).isActive = true
        sixMonth.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        sixMonth.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        sixMonth.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        oneYear.leadingAnchor.constraint(equalTo: sixMonth.trailingAnchor).isActive = true
        oneYear.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        oneYear.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        oneYear.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        oneYear.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        percentLabel.bottomAnchor.constraint(equalTo: graphView.topAnchor, constant: -40).isActive = true
        percentLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        percentLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200).isActive = true
        
        
        
        
        yearChangeLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 30).isActive = true
        yearChangeLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        yearChangeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -200).isActive = true
        */
        
         
    }
}
    extension DetailedViewController: UICollectionViewDelegate {
        
    }

    extension DetailedViewController: transactionViewDelegate {
        
        @objc func addBuyTransactionPopup() {
            // 1 - Add dim background
            let bg = UIView()
            bg.backgroundColor = UIColor.gray
            bg.alpha = 0.0
            bg.frame = view.frame
            view.addSubview(bg)
            UIView.animate(withDuration: 0.3, animations: {
                bg.alpha = 0.45
            })
            bg.tag = 99
            
            // 2 - Add popup view
            let popup = transactionPopup()
            popup.symbolLabel.text = symbolLabel.text
            popup.priceLabel.text = priceLabel.text
            popup.buttonString = "BUY"
            popup.delegate = self
            view.addSubview(popup)
            
        }
        @objc func addSellTransactionPopup() {
            // 1 - Add dim background
            let bg = UIView()
            bg.backgroundColor = UIColor.gray
            bg.alpha = 0.0
            bg.frame = view.frame
            view.addSubview(bg)
            UIView.animate(withDuration: 0.3, animations: {
                bg.alpha = 0.45
            })
            bg.tag = 99
            
            // 2 - Add popup view
            let popup = transactionPopup()
            popup.symbolLabel.text = symbolLabel.text
            popup.priceLabel.text = priceLabel.text
            popup.buttonString = "SELL"
            popup.delegate = self
            view.addSubview(popup)
            
        }
        
        func hideFoodPopup() {
            // 2 - Remove dim background
            let bg = self.view.viewWithTag(99)!
            UIView.animate(withDuration: 0.3, animations: {
                bg.alpha = 0.0
            }, completion: { completed in
                bg.removeFromSuperview()
            })
        }
        
        func closePopup() {
            hideFoodPopup()
        }
        
        
    }




