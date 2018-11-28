//
//  TableViewController.swift
//  EventSearch
//
//  Created by LCL on 11/27/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import SwiftyJSON
class TableViewController: UITableViewController {
    
    var rawData:Any!;
    var JSONData = JSON();
    var prepareData = JSON();
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(rawData)
        JSONData = JSON(rawData)
        print(JSONData["_embedded"]["events"].count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return JSONData["_embedded"]["events"].count
//        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! EventsCell
        cell.EventName.text = JSONData["_embedded"]["events"][indexPath.row]["name"].string
        cell.EventVenue.text = JSONData["_embedded"]["events"][indexPath.row]["_embedded"]["venues"][0]["name"].string
        cell.EventDate.text = JSONData["_embedded"]["events"][indexPath.row]["dates"]["start"]["localDate"].string
        cell.EventDate.text = (cell.EventDate.text ?? "") + " "
        cell.EventDate.text = cell.EventDate.text! + (JSONData["_embedded"]["events"][indexPath.row]["dates"]["start"]["localTime"].string ?? "")
//         Configure the cell...
//        let url = URL(string: JSONData["_embedded"]["events"][indexPath.row]["images"][0]["url"].string!)
//        //从网络获取数据流
//        let data = try! Data(contentsOf: url!)
//        //通过数据流初始化图片
//        let newImage = UIImage(data: data)
//
//        cell.EventPic.image = newImage
        if(JSONData["_embedded"]["events"][indexPath.row]["classifications"][0]["segment"]["name"].string == "Sports"){
            cell.EventPic.image = UIImage(named: "sports")
        }
        if(JSONData["_embedded"]["events"][indexPath.row]["classifications"][0]["segment"]["name"].string == "Music"){
            cell.EventPic.image = UIImage(named: "music")
        }
        if(JSONData["_embedded"]["events"][indexPath.row]["classifications"][0]["segment"]["name"].string == "Arts & Theatre"){
            cell.EventPic.image = UIImage(named: "arts")
        }
        if(JSONData["_embedded"]["events"][indexPath.row]["classifications"][0]["segment"]["name"].string == "Film"){
            cell.EventPic.image = UIImage(named: "film")
        }
        if(JSONData["_embedded"]["events"][indexPath.row]["classifications"][0]["segment"]["name"].string == "Miscellaneous"){
            cell.EventPic.image = UIImage(named: "miscellaneous")
        }
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
//        print(2)
        let des = segue.destination as! TabBarController
        des.input = prepareData
        
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        prepareData = JSONData["_embedded"]["events"][indexPath.row]
//        print(1)
        self.performSegue(withIdentifier: "JumpToTabBar", sender: self)
    }
}
