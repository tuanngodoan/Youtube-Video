//
//  TrendingTableViewCell.swift
//  Youtube
//
//  Created by Doan Tuan on 5/8/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleVideoLabel:UILabel!
    //@IBOutlet weak var titleChannelLabel:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
