//
//  NSObject.swift
//  SAPTask
//
//  Created by Ajay Kumar on 03/02/2022.
//

import Swift
import UIKit

extension NSObject {
    static func nameOfClass() -> String {
        return NSStringFromClass(self as AnyClass).components(separatedBy: ".").last!
    }
}
