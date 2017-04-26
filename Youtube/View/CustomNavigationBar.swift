//
//  CustomNavigationBar.swift
//  Youtube
//
//  Created by Doan Tuan on 4/23/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customNavigation()
    }
    
    func customNavigation(){
        //barTintColor = UIColor.red
        barTintColor = UIColor(red: 204/255, green: 24/255, blue: 30/255, alpha: 0.8)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
