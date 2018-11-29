//
//  NetworkService.swift
//  EventSearch
//
//  Created by LCL on 11/20/18.
//  Copyright © 2018 LCL. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class NetworkService: NSObject {
    struct CustomEncoding: ParameterEncoding {
        func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var request = try! URLEncoding().encode(urlRequest, with: parameters)
            let urlString = request.url?.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "=")
            request.url = URL(string: urlString!)
            return request
        }
    }
//    func GetGeo(finishedCallBack: @escaping (_ result : Any)->()){
//        var ans = ["lat":"","lon":""];
//        Alamofire.request("http://ip-api.com/json").validate().responseJSON(completionHandler: {response in
//            let json  = response.result.value as! Dictionary<String, Any>;
//            ans["lat"] = String(json["lat"] as! Double);
//            ans["lon"] = String(json["lon"] as! Double);
//            finishedCallBack(ans);
//        });
//    }
    func GetTicketMaster(para:Parameters, finishedCallBack: @escaping (_ result : Any)->()){
        let URLString = "http://lclnode.us-west-1.elasticbeanstalk.com/users/SearchEventTM";
        Alamofire.request(URLString, parameters: para).validate().responseJSON(completionHandler: {(response) in
            let json = JSON(response.result.value as Any) ;
//            print(json);
            finishedCallBack(json);
        })
    }
    func GetAutocomplete(para:Parameters, finishedCallBack: @escaping (_ result : Any)->()){
        let URLString = "http://lclnode.us-west-1.elasticbeanstalk.com/users/autoComplete";
        Alamofire.request(URLString, parameters: para).validate().responseJSON(completionHandler: {(response) in
            let json = JSON(response.result.value as Any) ;
//            print(json);
            finishedCallBack(json["_embedded"]["attractions"]);
        })
    }
    func GetUpcoming(para:Parameters, finishedCallBack: @escaping (_ result : Any)->()){
        let URLString = "http://localhost:8081/users/reqUpcoming";
        Alamofire.request(URLString, parameters: para).validate().responseJSON(completionHandler: {(response) in
            let json = JSON(response.result.value as Any) ;
            //            print(json);
            finishedCallBack(json);
        })
    }
    func GetSpotify(para:Parameters, finishedCallBack: @escaping (_ result : Any)->()){
        let URLString = "http://localhost:8081/users/reqSpotify";
        Alamofire.request(URLString, parameters: para, encoding: CustomEncoding()).validate().responseJSON(completionHandler: {(response) in
            let json = JSON(response.result.value as Any) ;
            //            print(json);
            finishedCallBack(json);
        })
    }
    func GetPics(para:Parameters, finishedCallBack: @escaping (_ result : Any)->()){
        let URLString = "http://localhost:8081/users/reqGooglePics";
        Alamofire.request(URLString, parameters: para, encoding: CustomEncoding()).validate().responseJSON(completionHandler: {(response) in
            let json = JSON(response.result.value as Any) ;
            //            print(json);
            finishedCallBack(json);
        })
        
    }
}
