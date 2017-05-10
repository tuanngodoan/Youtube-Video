//
//  SuggestVideoTableViewCell.swift
//  Youtube
//
//  Created by Doan Tuan on 5/6/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class SuggestVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageVideoImageView: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var titleChannelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
