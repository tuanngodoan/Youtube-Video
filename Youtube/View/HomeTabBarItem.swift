//
//  HomeTabBarItem.swift
//  Youtube
//
//  Created by Doan Tuan on 5/7/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class HomeTabBarItem: UITabBarItem {
    
    override init() {
        super.init()
        image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
