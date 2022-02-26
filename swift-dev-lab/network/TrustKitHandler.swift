//
//  TrustKitHandler.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import Foundation
import TrustKit

class TrustKitHandler {
    
    private func getTrustKitConfig() -> [String : Any] {
        TrustKit.setLoggerBlock { (message) in
            print("TrustKit log: \(message)")
        }
        let trustKitConfig: [String: Any] = [
            kTSKSwizzleNetworkDelegates: false,
            kTSKPinnedDomains: [
                "www.google.com": [
                    kTSKEnforcePinning: true,
                    kTSKIncludeSubdomains: false,
                    kTSKExpirationDate: "2022-12-30",
                    kTSKPublicKeyHashes: [
                        "47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=",
                        "zCTnfLwLKbS9S2sbp+uFz4KZOocFvXxkV06Ce9O5M2w="
                    ]
                ],
                "viacep.com.br": [
                    kTSKEnforcePinning: true,
                    kTSKIncludeSubdomains: false,
                    kTSKExpirationDate: "2022-12-30",
                    kTSKPublicKeyHashes: [
                        "M3uGk9RnuzI9Had2U8RA+AlgNjpNb8q0OZYRwb7pJX0=",
                        "4a6cPehI7OG6cuDZka5NDZ7FR8a60d3auda+sKfg4Ng="
                    ]
                ]
            ]
        ]
        
        return trustKitConfig
        
    }
    
    func trustKitInit() {
        TrustKit.initSharedInstance(withConfiguration: self.getTrustKitConfig())
    }
    
    static func validateTrustKit(challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // Call into TrustKit here to do pinning validation
        
        if TrustKit.sharedInstance().pinningValidator.handle(challenge, completionHandler: completionHandler) == false {
            // TrustKit did not handle this challenge: perhaps it was not for server trust
            // or the domain was not pinned. Fall back to the default behavior
            completionHandler(.performDefaultHandling, nil)
        }
    }
    
}
