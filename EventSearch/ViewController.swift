//
//  ViewController.swift
//  EventSearch
//
//  Created by LCL on 11/11/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import McPicker
import CoreLocation
import EasyToast
import SwiftSpinner
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource,UITableViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var keyword: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var unit: UIPickerView!
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var currentBtn: UIButton!
    @IBOutlet weak var customBtn: UIButton!
    @IBOutlet weak var AutocompleteTable: UITableView!
    
    
    var data = ["inputKeyword":"","inputCategory":"all","inputDistance":"10","distanceMeasure": "miles","inputFrom":"current","inputOther":"","lat":"","lon":""];
//    var chooseCat: UIPickerView!;
    var autoData = JSON();
    var categoryDelegate:UITextFieldDelegate!
    var NetworkClass:NetworkService!
    var locationManager = CLLocationManager()
    var resultFromServer:Any!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keyword.delegate = self;

        categoryDelegate = categoryPickerDelegate();
        category.delegate = categoryDelegate;
//        sourcetest = categoryPickerDelegate();
//        distance.delegate = self;
        unit.delegate = self;
        unit.dataSource = self;
        AutocompleteTable.delegate = self;
        AutocompleteTable.dataSource = self;
        currentBtn.layer.cornerRadius = 11;
        customBtn.layer.cornerRadius = 11;
        currentBtn.layer.borderColor = UIColor.gray.cgColor;
        currentBtn.layer.backgroundColor = UIColor.gray.cgColor;
        customBtn.layer.backgroundColor = UIColor.white.cgColor;
        customBtn.layer.borderColor = UIColor.gray.cgColor;
        currentBtn.layer.borderWidth = 2;
        customBtn.layer.borderWidth = 2;
        NetworkClass = NetworkService();
//        NetworkClass.GetGeo(finishedCallBack: {(result) in
//            print(result);
//            let nresult = result as! NSDictionary;
//            self.data["lat"] = nresult["lat"] as? String;
//            self.data["lon"] = nresult["lon"] as? String;
//        })
        AutocompleteTable.reloadData();
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        AutocompleteTable.register(UITableViewCell.self, forCellReuseIdentifier: "AutoTableViewCell")
    }
    @IBAction func KeywordChange(_ sender: Any) {
        var req = ["keyword":""]
        if(keyword.text!.count>0){
            req["keyword"] = keyword.text
            NetworkClass.GetAutocomplete(para: req, finishedCallBack: {(result) in
                self.AutocompleteTable.isHidden = false
                self.autoData = JSON(result)
                self.AutocompleteTable.reloadData()
                })
        }
        else
        {
            AutocompleteTable.isHidden = true;
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        AutocompleteTable.isHidden = true;
        return true;
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.count-1]
//        var currLocation = locations.last!
        //判断是否为空
        if(location.horizontalAccuracy > 0){
            data["lat"] =  String(location.coordinate.latitude)
            data["lon"] =  String(location.coordinate.longitude)
            print("纬度:\(String(describing: data["lat"]))")
            print("经度:\(String(describing: data["lon"]))")
            //停止定位
            locationManager.stopUpdatingLocation()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let des = segue.destination as! TableViewController
        des.rawData = resultFromServer;
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var sArray = ["Miles","Kilometers"];
        return sArray[row];
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sArray = ["miles","km"]
        data["distanceMeasure"] = sArray[row];
    }
    @IBAction func clear(_ sender: Any) {
        keyword.text = "";
        category.text = "All";
        distance.text = "";
        unit.selectRow(0, inComponent: 0, animated: true);
        selectCurrent(currentBtn);
        from.text = "";
    }
    @IBAction func selectCurrent(_ sender: Any) {
        currentBtn.layer.backgroundColor = UIColor.gray.cgColor;
        customBtn.layer.backgroundColor = UIColor.white.cgColor;
        data["inputFrom"] = "current";
        from.isEnabled = false;
//        AutocompleteTable.reloadData()
    }
    @IBAction func selectCustom(_ sender: Any) {
        customBtn.layer.backgroundColor = UIColor.gray.cgColor;
        currentBtn.layer.backgroundColor = UIColor.white.cgColor;
        data["inputFrom"] = "other";
        from.isEnabled = true;
//        AutocompleteTable.reloadData()
    }
    @IBAction func startSerach(_ sender: Any) {
        AutocompleteTable.isHidden = true;
        var cateMap = ["All":"all","Music":"music","Sports":"sports","Art & theatre":"art_theatre","Film":"film","Miscellaneous":"miscellaneous"];
        data["inputKeyword"] = keyword.text;
        data["inputCategory"] = cateMap[category.text ?? "all"];
        data["inputDistance"] = distance.text;
        if(data["inputFrom"] != "current"){
            data["inputOther"] = from.text;
        }
        else
        {
            data["inputOther"] = "";
        }
        print(data);

        if(data["inputFrom"] == "current"&&data["lat"]==""||data["inputFrom"]=="other"&&from.text==""||keyword.text=="")
        {
            self.view.showToast("Keyword and location are mandatory fields", position: .bottom, popTime: 5, dismissOnTap: false)
//            print("somethings wrong...");
            return;
        }
        SwiftSpinner.show("Searching for events...")
        NetworkClass.GetTicketMaster(para: data, finishedCallBack: {(result) in
//            print(result);
            self.resultFromServer = result
            SwiftSpinner.hide()
            self.performSegue(withIdentifier: "JumpToTableView", sender: self)
            //        prepare(for: triggerToDetail(), sender: self);
        
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AutoTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Fetches the appropriate meal for the data source layout.
//        let meal = meals[indexPath.row]
        
//        cell.nameLabel.text = meal.name
//        cell.photoImageView.image = meal.photo
//        cell.ratingControl.rating = meal.rating
        cell.textLabel?.text = autoData[indexPath.row]["name"].string;
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        keyword.text = autoData[indexPath.row]["name"].string;
        AutocompleteTable.isHidden = true;
    }
}


public class categoryPickerDelegate:NSObject, UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        McPicker.show(data: [["All", "Music", "Sports", "Art & theatre", "Film", "Miscellaneous"]]) { (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                textField.text = name;
            }
        }
        return false;
    }
}
