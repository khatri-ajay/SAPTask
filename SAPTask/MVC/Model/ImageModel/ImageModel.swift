//
//  ImageModel.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import Foundation

class ImageModel: NSObject{
   class func createImageUrl(model: Photo) -> URL {
       var url = ServiceUrl.imageInitial + String(describing: model.farm) + ServiceUrl.imageAfterFrom
        url = url + model.server + "/" + model.id + "_" + model.secret + ".jpg"
        return URL(string: url)!
    }
    class func getPhotos(text: String,page: String,completionHandler: @escaping (Main?, Bool?, String?) -> ()) {
        var url = ServiceUrl.domainUrl + text
        url = url + "&page=" + page
        WebServices.sharedInstance.sendRequestToServer(urlString: url, methodType: HTTPMethods.get) {
            data, status, message in
            if status!{
                do{
                    let response: Main = try JSONDecoder().decode(Main.self, from: data!)
                    completionHandler(response,status,message?.localizedDescription)
                }catch let error {
                    completionHandler(nil,false,error.localizedDescription)
                }
            }else{
                completionHandler(nil,status,message?.localizedDescription)
            }
        }
    }
    
}
// MARK: - Main
struct Main: Decodable {
    let stat: String
    var photos: Photos
}

// MARK: - Photos
struct Photos: Decodable {
    var page, pages, perpage, total: Int
    var photo: [Photo] = []
}

// MARK: - Photo
struct Photo: Decodable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
