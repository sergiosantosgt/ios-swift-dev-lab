//
//  AddressService.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 01/03/22.
//

import Foundation
import Alamofire

class AddressService {
    
    // Lateinit
    
    @propertyWrapper
    struct Lateinit<T> {
      private var _value: T?
      
      var wrappedValue: T {
        get {
          guard let value = _value else {
            fatalError("Property being accessed without initialization")
          }
          return value
        }
        set {
          guard _value == nil else {
            fatalError("Property already initialized")
          }
          _value = newValue
        }
      }
    }
    
    @Lateinit static var lateAddress: Address
    
    let url = NetworkUrl()
    let fetchApiRequest = FetchApiRequest()
    
    public func getAddress(zipCode: String, completion: @escaping (_ response: Address?) -> Void) {
        let zipCodeURL = url.getAddressUrlByZipCode(zipCode: zipCode)
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
    
    public func getAddressAlamofire(zipCode: String, completion: @escaping (_ response: Address?) -> Void) {
        let zipCodeURL = url.getAddressUrlByZipCode(zipCode: zipCode)
        fetchApiRequest.makeRequestAlamofire(route: URL(string: zipCodeURL)!, method: HTTPMethod.get, completion: { (response) in
            let res = try?  JSONDecoder().decode(Address.self, from: response)
            completion(res)
        })
    }
}
