//
//  NetworkService.swift
//  EventSearch
//
//  Created by LCL on 11/20/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService: NSObject {
    
    func GetGeo(finishedCallBack: @escaping (_ result : Any)->()){
        var ans = ["lat":"","lon":""];
        Alamofire.request("http://ip-api.com/json").validate().responseJSON(completionHandler: {response in
            let json  = response.result.value as! Dictionary<String, Any>;
            ans["lat"] = String(json["lat"] as! Double);
            ans["lon"] = String(json["lon"] as! Double);
            finishedCallBack(ans);
        });
    }
    func GetTicketMaster(para:Parameters, finishedCallBack: @escaping (_ result : NSObject)->()){
        let URLString = "http://lclnode.us-west-1.elasticbeanstalk.com/users/SearchEventTM";
        Alamofire.request(URLString, parameters: para).validate().responseJSON(completionHandler: {(response) in
            let json = response.result.value as! NSObject;
            print(json);
            finishedCallBack(json);
            
        })
    }
}
