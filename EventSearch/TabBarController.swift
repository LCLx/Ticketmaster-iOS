//
//  TabBarController.swift
//  EventSearch
//
//  Created by LCL on 11/27/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import SwiftyJSON
class TabBarController: UITabBarController {

    var input = JSON()
    var twitterButton = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        initInfo()
        let twitterButton = UIBarButtonItem(image: UIImage(named: "twitter"), style: .plain, target: self, action: #selector(ClickTwitter))
        let favButton = UIBarButtonItem(image: UIImage(named: "favorite-empty"), style: .plain, target: self, action: #selector(ClickFav))
        self.navigationItem.rightBarButtonItems = [favButton,twitterButton]
        // Do any additional setup after loading the view.
    }
    
    func initInfo() {
        
        let infoTab = self.viewControllers?[0] as! InfoTabController
        infoTab.data = input
    }
    @objc func ClickTwitter(){
        let url:URL?=URL.init(string: getTwitterURL())
//        print(getTwitterURL())
//        print(url as Any)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    @objc func ClickFav(){
        
    }
    func getTwitterURL() -> String {
        var str = "https://twitter.com/intent/tweet?text=Check out "+(input["name"].string ?? "")
        if(input["_embedded"]["venues"][0]["name"].string != nil){
            str += " locate at " + input["_embedded"]["venues"][0]["name"].string!
        }
        str += ". Website: " + input["url"].string! +  " #CSCI571 EventSearch"
        return str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
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
