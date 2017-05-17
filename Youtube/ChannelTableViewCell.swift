//
//  ChannelTableViewCell.swift
//  Youtube
//
//  Created by Doan Tuan on 5/10/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    
    @IBOutlet weak var avataImage:UIImageView!
    @IBOutlet weak var titleChannel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
