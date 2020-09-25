//
//  ViewController+Ext.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 18..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit
import StoreKit

extension UIViewController {
    
    func displayMessageOK(title: String, description: String) {
        let alertVC = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func displayIAPError(error: Error){
        if let skError = error as? SKError {
            if skError.code == .paymentNotAllowed{
                displayMessageOK(title: "Error", description: "Unable to make purchase due to an unknown problem")
            }else if skError.code == .cloudServiceNetworkConnectionFailed{
                displayMessageOK(title: "Error", description: "Unable to make purchase due to network problem")
            }else if skError.code == .paymentCancelled{
                displayMessageOK(title: "Cancelled", description: "In-App-Purchase process was cancelled")
            }
        }else{
            displayMessageOK(title: "Error", description: "Unable to make purchase due to an unknown problem")
        }
    }
    
}
