//
//  CustomBarButton.swift
//  Youtube
//
//  Created by Doan Tuan on 4/22/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

@IBDesignable
open class CustomBarButton: UIBarButtonItem {
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customUserBarButton()
    }
    
    func customUserBarButton(){
        let button:UIButton = UIButton(type: UIButtonType.custom)
        
        button.setImage(UIImage(named: "user1.png"), for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        customView = button
    }
   
    
}
