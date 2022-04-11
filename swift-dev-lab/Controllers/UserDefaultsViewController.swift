//
//  UserDefaultsViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 04/04/22.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userDefaultLabel: UILabel!
    
    let userDefaults: SharedUserDefaults = SharedUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaultLabel.text = userDefaults.getUserNameKeychain()
        
        username.delegate = self
    }
    

}

extension UserDefaultsViewController: UITextFieldDelegate {
    
    // Execute search on press done
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userDefaults.setUserNameKeychain(value: textField.text!)
        userDefaultLabel.text = textField.text!
        textField.resignFirstResponder()
        return true;
    }
}
