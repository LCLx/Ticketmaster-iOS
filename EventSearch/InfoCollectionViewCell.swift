//
//  InfoCollectionViewCell.swift
//  EventSearch
//
//  Created by LCL on 11/29/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Followers: UILabel!
    @IBOutlet weak var Popularity: UILabel!
    var SpotifyUrl = ""
    @IBAction func ShowSpotify(_ sender: Any) {
        let url:URL?=URL.init(string: SpotifyUrl)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
}
