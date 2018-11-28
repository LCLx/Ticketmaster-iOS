//
//  InfoTabController.swift
//  EventSearch
//
//  Created by LCL on 11/27/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import SwiftyJSON
class InfoTabController: UIViewController {

    @IBOutlet weak var Artists: UILabel!
    @IBOutlet weak var Venue: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var PriceRange: UILabel!
    @IBOutlet weak var TicketStatus: UILabel!
    @IBOutlet weak var BuyTicketAt: UIButton!
    @IBOutlet weak var SeatMap: UIButton!
    
    
    var data = JSON()
    override func viewDidLoad() {
        super.viewDidLoad()
        Artists.text = getArtists()
        Venue.text = getVenue()
        Time.text = getTime()
        Category.text = getCategory()
        PriceRange.text = getPriceRange()
        TicketStatus.text = getTicketStatus().capitalized
        
        // Do any additional setup after loading the view.
    }
    @IBAction func ClickTM(_ sender: Any) {
        let url:URL?=URL.init(string: getBuyURL())
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    @IBAction func ClickSeatMap(_ sender: Any) {
        let url:URL?=URL.init(string: getSeatMapUrl())
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    func getArtists() -> String {
        var ans  = ""
        for (index,subJson):(String, JSON) in data["_embedded"]["attractions"] {
            // Do something you want
            if(index != "0"){
                ans += " | "
            }
            ans += subJson["name"].string!
        }
        return ans
    }
    func getVenue() -> String {
        return data["_embedded"]["venues"][0]["name"].string ?? "N/A"
    }
    func getTime() -> String {
        var ans = ""
        var date = Date();
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd";
        date = formatter.date(from: data["dates"]["start"]["localDate"].string!)!;
        formatter.dateFormat = "MMM dd, yyyy";
        ans += formatter.string(from: date);
        ans += " "
        ans += data["dates"]["start"]["localTime"].string ?? ""
        if(ans == "")
        {
            ans = "N/A"
        }
        return ans;
    }
    func getCategory() ->String{
        var ans = data["classifications"][0]["segment"]["name"].string ?? ""
        if(ans != "" && (data["classifications"][0]["genre"]["name"].string != nil))
        {
            ans+=" | "
        }
        ans += data["classifications"][0]["genre"]["name"].string ?? ""
        if(ans == "")
        {
            ans = "N/A"
        }
        return ans
    }
    func getPriceRange() ->String{
        var ans = data["priceRanges"][0]["min"].string ?? ""
        if(ans != "" && (data["priceRanges"][0]["max"].string != nil)){
            ans += " ~ "
        }
        ans += data["priceRanges"][0]["max"].string ?? ""
        if(ans == ""){
            ans = "N/A"
        }
        return ans
    }
    func getTicketStatus() -> String {
        return data["dates"]["status"]["code"].string ?? "N/A"
    }
    func getBuyURL() -> String {
        return data["url"].string!
    }
    
    func getSeatMapUrl() -> String {
        return data["seatmap"]["staticUrl"].string ?? ""
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
