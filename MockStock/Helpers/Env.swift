//
//  Env.swift
//  MockStock
//
//  Created by Luke Orr on 3/25/19.
//  Copyright © 2019 Theodore Hecht. All rights reserved.
//

import UIKit

class Env {
    
    static var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
