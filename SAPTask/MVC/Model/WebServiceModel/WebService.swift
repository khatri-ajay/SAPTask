//
//  WebService.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import Foundation
import Alamofire

class WebServices : NSObject{
    static let sharedInstance = WebServices()
    func sendRequestToServer(urlString: String,
                               methodType : HTTPMethods,
                               param :[String : AnyObject]? = nil,
                               shouldShowHud : Bool = true,
                               shouldShowMessageAlert : Bool = true,
                               completionHandler: @escaping (Data?, Bool?, Error?) -> ())
    {
        
        let serviceUrl = urlString
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded)
        {
        AF.request(url, method: typeMethod, encoding: JSONEncoding.default, headers: getHeaders())
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let object = data
                    completionHandler(object, true,nil)
                case .failure(let error):
                    completionHandler(nil,false,error)
            }
            
            }
            
        }
    }
    func getHeaders()->(HTTPHeaders){
        return ["accept":"application/json"]
    }
}
