//
//  VenueViewController.swift
//  EventSearch
//
//  Created by LCL on 11/28/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import SwiftyJSON
import GoogleMaps
class VenueViewController: UIViewController {
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var OpenHours: UILabel!
    @IBOutlet weak var GeneralRules: UILabel!
    @IBOutlet weak var ChildRules: UILabel!
    @IBOutlet weak var GoogleMaps: UIView!
    @IBOutlet weak var NoResults: UILabel!
    @IBOutlet weak var ScrollView: UIScrollView!
    
    var data = JSON()
    override func viewDidLoad() {
        super.viewDidLoad()
        if(data.isEmpty){
            ScrollView.isHidden = true
            NoResults.isHidden = false
            return
        }
        load()
        // Do any additional setup after loading the view.
    }
    func load() {
        Address.text = data["address"]["line1"].string ?? "N/A"
        City.text = data["city"]["name"].stringValue + ", " + data["state"]["name"].stringValue
        PhoneNumber.text = data["boxOfficeInfo"]["phoneNumberDetail"].string ?? "N/A"
        OpenHours.text = data["boxOfficeInfo"]["openHoursDetail"].string ?? "N/A"
        GeneralRules.text = data["generalInfo"]["generalRule"].string ?? "N/A"
        ChildRules.text = data["generalInfo"]["childRule"].string ?? "N/A"
//        print("loading...")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(data["location"]["latitude"].string != nil){
            let des = segue.destination as! GoogleMapsViewController
            //        print(data["location"]["latitude"].string)
            des.lat = Double(data["location"]["latitude"].stringValue)
            des.lon = Double(data["location"]["longitude"].stringValue)
        }
        
        
//        print("segueing")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
