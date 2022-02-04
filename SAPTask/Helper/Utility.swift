//
//  Utility.swift
//  SAPTask
//
//  Created by Ajay Kumar on 04/02/2022.
//

import Foundation
import UIKit

class Utility {
    class func showAlertwithOkButton(message: String , controller: AnyObject){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action -> Void in
            alert.dismiss(animated: false, completion: nil)
        })
        alert.addAction(okAction)
        controller.present(alert, animated: false, completion: nil)
    }
}
