//
//  ViewController.swift
//  EventSearch
//
//  Created by LCL on 11/11/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var keyword: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var distance: UITextField!
    @IBOutlet weak var unit: UIPickerView!
    @IBOutlet weak var from: UITextField!
    
    var data = ["keyword":"","category":"all","distance":"10","units": "miles","from":"current","fromLocation":"","lat":"","lon":""];
    var sourcetest:categoryPickerDelegate!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        keyword.delegate = self;
        category.delegate = self;
        sourcetest = categoryPickerDelegate();
        unit.delegate = self;
        unit.dataSource = self;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        category.text = keyword.text;
//        distance.text = textField.text;
//    }
    
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
}

public class categoryPickerDelegate:NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6;
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var sArray = ["All","Music","Sports","Art & theatre","File","Miscellaneous"];
        return sArray[row];
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let sArray = ["miles","km"]
//        data["units"] = sArray[row];

    }
    
}
