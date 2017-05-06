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
    @IBOutlet weak var titleVideoLabel:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbImage.frame = CGRect(x: 0, y: 0, width:  self.frame.width, height:  self.frame.width * 9 / 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
