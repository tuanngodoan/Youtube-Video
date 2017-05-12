//
//  InfoVideoTableViewCell.swift
//  Youtube
//
//  Created by Doan Tuan on 5/6/17.
//  Copyright © 2017 Doan Tuan. All rights reserved.
//

import UIKit

class InfoVideoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var TitleVideoLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var dislikeCountLabel: UILabel!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var numSubLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
