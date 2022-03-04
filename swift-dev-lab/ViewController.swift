//
//  ViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var neighborhoodLabel: UILabel!
    @IBOutlet weak var addressCityLabel: UILabel!
    @IBOutlet weak var addressStateLabel: UILabel!
    
    
    // Init Address Service
    let addressService = AddressService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init zipCode empty
        addressTextField.delegate = self
        self.addressLabel.text = ""
        self.neighborhoodLabel.text = ""
        self.addressCityLabel.text = ""
        self.addressStateLabel.text = ""
        
    }
    
    func getAddress(text: String) {
        // Make Http Request
        addressService.getAddress(zipCode: text, completion: { (response) in
            print("RESPONSE \(String(describing: response))")
            self.addressLabel.text = response?.logradouro
            self.neighborhoodLabel.text = response?.bairro
            self.addressCityLabel.text = response?.localidade
            self.addressStateLabel.text = response?.uf
        })
    }

}

// Extension to bypass SSL Verify - localhost
extension ViewController: URLSessionDelegate {
//    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//       //Trust the certificate even if not valid
//        if(Bundle.main.infoDictionary?["isHml"] as? Bool ?? false) {
//            let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, urlCredential)
//        }
//    }
}

extension ViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("DONE")
        getAddress(text: textField.text!)
        textField.resignFirstResponder()
        return true;
    }
}
