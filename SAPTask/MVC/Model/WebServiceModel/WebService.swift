//
//  WebService.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import Foundation
import Alamofire

class WebServices : NSObject{
    
    var alertWindow : UIWindow!
    static let sharedInstance = WebServices()
    func sendRequestToServer(urlString: String,
                               methodType : HTTPMethods,
                               param :[String : AnyObject]? = nil,
                               shouldShowHud : Bool = true,
                               shouldShowMessageAlert : Bool = true,
                               completionHandler: @escaping (NSDictionary?, Bool?, Error?) -> ())
    {
        
        let serviceUrl = urlString
        print("serviceUrl " ,serviceUrl)
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)
        AF.request(serviceUrl, method: typeMethod, encoding: JSONEncoding.default, headers: getHeaders())
            .responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let object = JSON as? NSDictionary
                completionHandler(object, true,nil)
            case .failure(let error):
                completionHandler(nil,false,error)
            }
    }
    }
    func getHeaders()->(HTTPHeaders){
        return ["accept":"application/json"]
    }
}
