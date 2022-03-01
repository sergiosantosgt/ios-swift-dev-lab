//
//  FetchApiRequest.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import Foundation
import TrustKit

class FetchApiRequest: UIViewController, URLSessionDelegate {
    
    static let shared = FetchApiRequest()
    
    lazy var session: URLSession = {
        URLSession(configuration: URLSessionConfiguration.ephemeral,
                                         delegate: self,
                                         delegateQueue: OperationQueue.main)
    }()
    
    func fetchApiRequest(url: String, method: String, data: Any, completion: @escaping (_ response: Any?) -> Void, errorState: @escaping (_ errorState: URLError?) -> Void) {

        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        /*if(Bundle.main.infoDictionary?["isHml"] as? Bool ?? false) {
            // get session from View
            self.session = viewSession
        }*/
        
        let task = self.session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.global().sync {
                if let error = error {
                    errorState(error as? URLError)
                } else {
                    do {
                        let res = try JSONSerialization.jsonObject(with: data!)
                        let dataDecoded = try JSONSerialization.data(withJSONObject: res, options: [])
                        completion(dataDecoded)
                        /*DispatchQueue.main.async {
                            let res = try JSONSerialization.jsonObject(with: data!)
                            print("fetchApiRequest *** \(data)")
                            completion(data)
                        }*/
                    } catch {
                        errorState(error as? URLError)
                    }
                }
            }
        }
        task.resume()
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // SSL Pinning validation
        TrustKitHandler.validateTrustKit(challenge: challenge, completionHandler: completionHandler)
    }
    
}
