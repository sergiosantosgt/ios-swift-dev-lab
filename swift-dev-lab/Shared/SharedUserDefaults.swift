//
//  UserDefault.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 04/04/22.
//

import Foundation
import SwiftKeychainWrapper

class SharedUserDefaults {
    
    public func setUserNameKeychain(value: String) {
        KeychainWrapper.standard.set(value, forKey: CONSTANTS.USERNAME.rawValue)
    }
    
    public func getUserNameKeychain() -> String {
        return KeychainWrapper.standard.string(forKey: CONSTANTS.USERNAME.rawValue) ?? ""
    }
    
    public func removeUserNameKeychain() {
        KeychainWrapper.standard.removeObject(forKey: CONSTANTS.USERNAME.rawValue)
    }
}
