//
//  UpcomingTableViewCell.swift
//  EventSearch
//
//  Created by LCL on 11/28/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    @IBOutlet weak var eventName: UIButton!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var type: UILabel!
    var eventURL = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func openEvent(_ sender: Any) {
        let url:URL?=URL.init(string: eventURL)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
}
