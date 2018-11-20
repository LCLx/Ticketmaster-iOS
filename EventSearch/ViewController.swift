//
//  ViewController.swift
//  EventSearch
//
//  Created by LCL on 11/11/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import McPicker

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var keyword: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var unit: UIPickerView!
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var currentBtn: UIButton!
    @IBOutlet weak var customBtn: UIButton!
    
    var data = ["keyword":"","category":"all","distance":"10","units": "miles","from":"current","fromLocation":"","lat":"","lon":""];
//    var chooseCat: UIPickerView!;
    
    var categoryDelegate:UITextFieldDelegate!
    var NetworkClass:NetworkService!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keyword.delegate = self;
        category.delegate = self;
        categoryDelegate = categoryPickerDelegate();
        category.delegate = categoryDelegate;
//        sourcetest = categoryPickerDelegate();
        distance.delegate = self;
        unit.delegate = self;
        unit.dataSource = self;
        currentBtn.layer.cornerRadius = 11;
        customBtn.layer.cornerRadius = 11;
        currentBtn.layer.borderColor = UIColor.gray.cgColor;
        currentBtn.layer.backgroundColor = UIColor.gray.cgColor;
        customBtn.layer.backgroundColor = UIColor.white.cgColor;
        customBtn.layer.borderColor = UIColor.gray.cgColor;
        currentBtn.layer.borderWidth = 2;
        customBtn.layer.borderWidth = 2;
        NetworkClass = NetworkService();
        NetworkClass.GetGeo(finishedCallBack: {(result) in
            print(result);
            let nresult = result as! NSDictionary;
            self.data["lat"] = nresult["lat"] as? String;
            self.data["lon"] = nresult["lon"] as? String;
        })
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
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
        data["units"] = sArray[row];
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
        data["from"] = "current";
        from.isEnabled = false;
    }
    @IBAction func selectCustom(_ sender: Any) {
        customBtn.layer.backgroundColor = UIColor.gray.cgColor;
        currentBtn.layer.backgroundColor = UIColor.white.cgColor;
        data["from"] = "other";
        from.isEnabled = true;
    }
    @IBAction func startSerach(_ sender: Any) {
        var cateMap = ["All":"all","Music":"music","Sports":"sports","Art & theatre":"art_theatre","Film":"film","Miscellaneous":"micellaneous"];
        data["keyword"] = keyword.text;
        data["category"] = cateMap[category.text ?? "all"];
        data["distance"] = distance.text;
        if(data["from"] != "current"){
            data["fromLocation"] = from.text;
        }
        else
        {
            data["fromLocation"] = "";
        }
        print(data);

        if(data["from"] == "current"&&data["lat"]==""||data["from"]=="other"&&from.text==""||keyword.text=="")
        {
            print("somethings wrong...");
            return;
        }
        NetworkClass.GetTicketMaster(para: data, finishedCallBack: {(result) in
            print(result);
        })
        performSegue(withIdentifier: "JumpToTableView", sender: self)
        //        prepare(for: triggerToDetail(), sender: self);
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
