//
//  ADUtils.swift
//  Xor-AthocDemo
//
//  Created by Sahil Ratnani on 29/04/23.
//

import UIKit

class ADUtils {
    class func displayAlert(title: String,
                            message: String,
                            senderViewController: UIViewController? = nil,
                            alertDisplayedHandler : @escaping ()-> Void = {}) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .destructive) { (action) in
        }
        alert.addAction(alertAction)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            assertionFailure("Could not get app window")
            return
        }
        
        var viewController = window.topMostWindowController()
        if senderViewController != nil {
            viewController = senderViewController
        }
        if let _ = viewController?.presentedViewController as? UIAlertController{
            
        } else {
            viewController!.present(alert, animated: true, completion: {
                alertDisplayedHandler()
            })
        }
        
    }
}
