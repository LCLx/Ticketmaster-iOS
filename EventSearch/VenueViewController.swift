//
//  VenueViewController.swift
//  EventSearch
//
//  Created by LCL on 11/28/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import SwiftyJSON

class VenueViewController: UIViewController {
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var City: UILabel!
    @IBOutlet weak var PhoneNumber: UILabel!
    @IBOutlet weak var OpenHours: UILabel!
    @IBOutlet weak var GeneralRules: UILabel!
    @IBOutlet weak var ChildRules: UILabel!
    
    var data = JSON()
    override func viewDidLoad() {
        super.viewDidLoad()
//        if(data.isEmpty){
//
//        }
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
