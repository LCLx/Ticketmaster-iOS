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

    override func viewDidLoad() {
        super.viewDidLoad()
        initInfo()
        // Do any additional setup after loading the view.
    }
    
    func initInfo() {
        
        let infoTab = self.viewControllers?[0] as! InfoTabController
        infoTab.data = input
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
