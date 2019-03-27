//
//  MarketplaceViewController.swift
//  MockStock
//
//  Created by Theodore Hecht on 3/3/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import Foundation
import UIKit

var viewLabel: UIButton = {
    let b = UIButton()
    b.setTitle("MarketPlace", for: .normal)
    b.titleLabel?.font = UIFont(name: "Futura-CondensedExtraBold", size: 18)
    b.setTitleColor(.red, for: .normal)
    b.frame = CGRect(x: 25, y: 100, width: 500, height: 25)
    return b
}()
class MarketplaceViewController: UICollectionViewController {
    private let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*// Test label -- Remove it later
        view.addSubview(viewLabel)
        // End test label
        viewLabel.addTarget(self, action: #selector(MarketplaceViewController.detailedButtonPressed(button:)), for: .touchUpInside)
        */
        collectionView?.backgroundColor = UIColor.white
        
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as!CategoryCell
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->Int {
        return 10
    }

    @objc func detailedButtonPressed(button:UIButton){
        let mainVC = DetailedViewController()
        present(mainVC, animated: true, completion: nil)
        
    }
    
    class CategoryCell: UICollectionViewCell {
        override init(frame:CGRect){
            super.init(frame: frame)
            setup Views()
        }
    }
}
