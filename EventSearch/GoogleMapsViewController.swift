//
//  GoogleMapsViewController.swift
//  EventSearch
//
//  Created by LCL on 11/28/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapsViewController: UIViewController {

    var lat: Double?
    var lon: Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        if(lat != nil){
            print(lat!,lon!)
            let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lon!, zoom: 14)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
            marker.map = mapView
        }
        // Do any additional setup after loading the view.
    }
    
//    override func loadView() {
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
