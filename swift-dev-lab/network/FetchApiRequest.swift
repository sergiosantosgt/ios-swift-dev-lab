//
//  FetchApiRequest.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import Foundation
import TrustKit
import Alamofire

class FetchApiRequest: SessionDelegate {
    
    static let shared = FetchApiRequest()
    
    lazy var session: URLSession = {
        URLSession(configuration: URLSessionConfiguration.ephemeral,
                                         delegate: self,
                                         delegateQueue: OperationQueue.main)
    }()
    
    lazy var sessionManager: Session = {
        Session(configuration: URLSessionConfiguration.ephemeral, delegate: self)
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
                    } catch {
                        errorState(error as? URLError)
                    }
                }
            }
        }
        task.resume()
    }
    
    func makeRequestAlamofire(route: URL, method: HTTPMethod, parameter: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (_ response: Data) -> Void){
          
        sessionManager.request(route, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers ).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseData { response in
                  //Pin Validtion returner
                  guard response.error == nil else {
                      // Display Error Alert
                      print("Result Pinning validation failed for \(route.absoluteString)\n\n\(response.error.debugDescription)")
                      return
                  }
                  switch response.result {
                    case .success:
                      guard let ret = response.data else { return }
                      completion(ret)
                    case .failure(let error):
                      print("Alamofire Request Fail \(error)")
                  }
          }
      }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // SSL Pinning validation
        TrustKitHandler.validateTrustKit(challenge: challenge, completionHandler: completionHandler)
    }
    
}
