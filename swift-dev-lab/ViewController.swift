//
//  ViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var zipCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init zipCode empty
        self.zipCode.text = ""
        
        let addressService = AddressService()
        addressService.getAddress(zipCode: "01001000", completion: { (response) in
            print("RESPONSE \(String(describing: response))")
            self.zipCode.text = response?.cep
        })
    }


}

// Extension to bypass SSL Verify - localhost
extension ViewController: URLSessionDelegate {
//    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//       //Trust the certificate even if not valid
//        if(Bundle.main.infoDictionary?["isHK"] as? Bool ?? false) {
//            print("Ambiente de HK: Aplicando urlCredential rule")
//            let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, urlCredential)
//        }
//    }
}
