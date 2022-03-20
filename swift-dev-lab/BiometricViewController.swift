//
//  BiometricViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 16/03/22.
//

import Foundation
import UIKit
import LocalAuthentication

class BiometricViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationWithTouchID()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"

        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"

        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return
            }
            print(error)
        }
    }
    
}
