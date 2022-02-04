//
//  Constant.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import Foundation

struct Strings{
    static let searchBarPlaceholder = "Search"
}
struct ServiceUrl{
    static let domainUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=37ad288835e4c64fc0cb8af3f3a1a65d&format=json&nojsoncallback=1&safe_search=1&text="
    static let imageInitial = "https://farm"
    static let imageAfterFrom = ".static.flickr.com/"
}

public enum HTTPMethods: String {
    case get     = "GET"
}
struct History {
    static var SearchHistory: [String] = []
}
