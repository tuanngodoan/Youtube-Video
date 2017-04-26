//
//  VideoTableViewCell.swift
//  Youtube
//
//  Created by Doan Tuan on 4/21/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImage:UIImageView!
    @IBOutlet weak var avataChannelImage:UIImageView!
    @IBOutlet weak var titleVideoLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
