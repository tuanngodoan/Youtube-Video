//
//  TabarViewController.swift
//  Youtube
//
//  Created by Doan Tuan on 5/8/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class TabarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //customBarItem()
        self.tabBar.tintColor = UIColor.red
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func customBarItem(){
        
        let homeItem = self.tabBar.items?[0]
        homeItem?.image = UIImage(named: "home.png")?.withRenderingMode(.alwaysOriginal)
        
        let trendItem = self.tabBar.items?[1]
        trendItem?.image = UIImage(named: "trending.png")?.withRenderingMode(.alwaysOriginal)
        
        let subItem = self.tabBar.items?[2]
        subItem?.image = UIImage(named: "subscriptions.png")?.withRenderingMode(.alwaysOriginal)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
