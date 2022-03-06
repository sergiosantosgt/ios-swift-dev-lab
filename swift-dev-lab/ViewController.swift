//
//  ViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var neighborhoodLabel: UILabel!
    @IBOutlet weak var addressCityLabel: UILabel!
    @IBOutlet weak var addressStateLabel: UILabel!
    
    let limitLength = 9
    var someString = String()
    
    // Init Services
    let addressService = AddressService()
    let filmService = FilmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Alamofire test
        /*filmService.fetchFilms(completion: { (response) in
            print(response.all[0].title)
        })*/
        
        //init zipCode empty
        addressTextField.delegate = self
        self.addressLabel.text = ""
        self.neighborhoodLabel.text = ""
        self.addressCityLabel.text = ""
        self.addressStateLabel.text = ""
    }
    
    func getAddress(text: String) {
        // Make Simple Http Request
        // let session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: self, delegateQueue: OperationQueue.main)
        //addressService.getAddress(zipCode: text, completion: { (response) in
        //    print("RESPONSE \(String(describing: response))")
        //})
        
        addressService.getAddressAlamofire(zipCode: text, completion: { response in
            print("RESPONSE ALAMOFIRE \(String(describing: response))")
            self.addressLabel.text = response?.logradouro
            self.neighborhoodLabel.text = response?.bairro
            self.addressCityLabel.text = response?.localidade
            self.addressStateLabel.text = response?.uf
        })
        
    }

}

// Extension to bypass SSL Verify - localhost
//extension ViewController: URLSessionDelegate {
//    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//       //Trust the certificate even if not valid
//        if(Bundle.main.infoDictionary?["isHml"] as? Bool ?? false) {
//            let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, urlCredential)
//        }
//    }
//}

extension ViewController: UITextFieldDelegate {
    
    // Execute search on press done
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("DONE")
        getAddress(text: textField.text!)
        textField.resignFirstResponder()
        return true;
    }
    
    // Set ZipCode field maxLength
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= limitLength
    }
}
