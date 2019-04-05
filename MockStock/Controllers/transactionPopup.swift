import Foundation
import UIKit

protocol transactionViewDelegate {
    func closePopup()
}

class transactionPopup: UIView,UITextFieldDelegate {
    var bottomGradientBackground: UIView!
    var delegate: transactionViewDelegate?
    
    var symbolLabel: UILabel = {
        let b = UILabel()
        b.text=("")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-CondensedExtraBold", size: 40)
        b.translatesAutoresizingMaskIntoConstraints = false
        //b.textAlignment = .left
        return b
    }()
    
    var priceLabel: UILabel = {
        let b = UILabel()
        b.text=("")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-Bold", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        //b.textAlignment = .left
        return b
    }()
    var totalLabel: UILabel = {
        let b = UILabel()
        b.text=("")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-Bold", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .left
        return b
    }()
    var currentCash: UILabel = {
        let b = UILabel()
        b.text=("Cash: $1000000")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-Bold", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .left
        return b
    }()
    var stocksOwned: UILabel = {
        let b = UILabel()
        b.text=("Stocks owned: 5")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-Bold", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .left
        return b
    }()
    var textField: UITextField = {
        let b = UITextField()
        b.layer.borderColor = UIColor.gray.cgColor
        b.layer.borderWidth = 2.0
        b.layer.cornerRadius = 5.0
        b.keyboardType = UIKeyboardType.numberPad
        b.clipsToBounds = true
        b.returnKeyType = UIReturnKeyType.default
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    var amountText: UILabel = {
        let b = UILabel()
        b.text=("Amount")
        b.textColor = UIColor.black
        b.font = UIFont(name: "Futura-Bold", size: 18)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.textAlignment = .left
        return b
    }()
    var buttonString = ""
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.white
        if let sv = superview {
            let popupSize = CGSize(width: sv.frame.width * 0.9, height: sv.frame.height * 0.75)
            let popupOrigin = CGPoint(x: (sv.frame.width / 2) - (popupSize.width / 2),
                                      y: (sv.frame.height/2) - (popupSize.height/2))
            let initialOrigin = CGPoint(x: (sv.frame.width / 2) - (popupSize.width / 2),
                                        y: (sv.frame.height/6))
            let popupRect = CGRect(origin: initialOrigin, size: popupSize)
            self.alpha = 0.0
            self.frame = popupRect
            UIView.animate(withDuration: 0.8, animations: {
                self.alpha = 1.0
                self.frame = CGRect(origin: popupOrigin, size: popupSize)
                // WARNING: Does 'self' in this block create retain cycle (and memory leak)???
                //          Should I use weak self instead?
            })
            layer.cornerRadius = 25
        }
        self.clipsToBounds = true
        addProps()
        addBottomButtons()
        setupLayout()
    }
    
    func addProps() {
        
    }
    
    func addBottomButtons() {
        bottomGradientBackground = UIView()
        bottomGradientBackground.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomGradientBackground)
        bottomGradientBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomGradientBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomGradientBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomGradientBackground.heightAnchor.constraint(equalToConstant: self.frame.height * 0.13).isActive = true
        
        
        let splitView = UIView()
        let splitViewHeight = self.frame.height * 0.1
        splitView.backgroundColor = UIColor.white
        splitView.frame = CGRect(x: self.frame.width/2 - 1, y: (self.frame.height * 0.13 / 2) - splitViewHeight/2,
                                 width: 1, height: splitViewHeight)
        bottomGradientBackground.addSubview(splitView)
        
        let backButton = UIButton()
        backButton.translatesAutoresizingMaskIntoConstraints = false
        bottomGradientBackground.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: bottomGradientBackground.leadingAnchor).isActive = true
        backButton.trailingAnchor.constraint(equalTo: splitView.leadingAnchor).isActive = true
        backButton.centerYAnchor.constraint(equalTo: bottomGradientBackground.centerYAnchor).isActive = true
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.setTitle("BACK", for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        
        
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        bottomGradientBackground.addSubview(addButton)
        addButton.leadingAnchor.constraint(equalTo: splitView.leadingAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: bottomGradientBackground.trailingAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: bottomGradientBackground.centerYAnchor).isActive = true
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.setTitle(buttonString, for: .normal)
        
        
    }
    
    @objc func backButtonPressed() {
        print("Back pressed")
        self.removeFromSuperview()
        if let d = delegate {
            d.closePopup()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gColor1 = UIColor.red.cgColor
        let gColor2 = UIColor.blue.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [gColor1, gColor2]
        gradientLayer.frame = bottomGradientBackground.bounds
        bottomGradientBackground.layer.insertSublayer(gradientLayer, at: 0)
        print(gradientLayer.frame)
    }
    func setupLayout(){
        self.addSubview(symbolLabel)
        self.addSubview(priceLabel)
        self.addSubview(textField)
        self.addSubview(totalLabel)
        self.addSubview(currentCash)
        self.addSubview(stocksOwned)
        self.addSubview(amountText)
        priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 20).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor,constant: 3).isActive = true
        
        symbolLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -20).isActive = true
        symbolLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        symbolLabel.rightAnchor.constraint(equalTo: currentCash.leftAnchor).isActive = true
        
        currentCash.bottomAnchor.constraint(equalTo: symbolLabel.bottomAnchor).isActive = true
        currentCash.leftAnchor.constraint(equalTo: symbolLabel.rightAnchor,constant: 20).isActive = true
        currentCash.topAnchor.constraint(equalTo:self.topAnchor).isActive = true
        
        stocksOwned.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stocksOwned.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        stocksOwned.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        textField.topAnchor.constraint(equalTo: amountText.topAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: amountText.rightAnchor,constant: 3).isActive = true
        
        amountText.topAnchor.constraint(equalTo: stocksOwned.bottomAnchor, constant: 10).isActive = true
        amountText.rightAnchor.constraint(equalTo: textField.leftAnchor, constant: -3).isActive = true
        amountText.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
    }
    
}
