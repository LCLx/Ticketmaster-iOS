//
//  EventsCell.swift
//  EventSearch
//
//  Created by LCL on 11/27/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit

class EventsCell: UITableViewCell {

    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventVenue: UILabel!
    @IBOutlet weak var EventDate: UILabel!
    @IBOutlet weak var EventPic: UIImageView!
    @IBOutlet weak var LikedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
