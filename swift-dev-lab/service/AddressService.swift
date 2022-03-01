//
//  AddressService.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 01/03/22.
//

import Foundation

class AddressService {
    
    public func getAddress(zipCode: String, completion: @escaping (_ response: Address?) -> Void) {
        let url = NetworkUrl()
        let zipCodeURL = url.getAddressUrlByZipCode(zipCode: zipCode)
        let fetchApiRequest = FetchApiRequest()
        fetchApiRequest.fetchApiRequest(url: zipCodeURL, method: "GET", data: "",
            completion: { (response) in
                if let res = response as? Data {
                    print("Api response \(res)")
                    
                    let decoder = JSONDecoder()
                    do {
                        let address = try decoder.decode(Address.self, from: response as! Data)
                        completion(address)
                    } catch {
                        print("Fail decode Address \(error)")
                    }
                }
            }, errorState: { (error) in
                print("ERROR FETCH API \(String(describing: error))")
            })
    }

}
