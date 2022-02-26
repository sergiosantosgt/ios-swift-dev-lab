//
//  ViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 25/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral, delegate: self, delegateQueue: OperationQueue.main)
        let url = "https://www.google.com"
        let fetchApiRequest = FetchApiRequest()
        fetchApiRequest.fetchApiRequest(url: url, method: "GET", data: "", viewSession: session,
            completion: { (response) in
                if let res = response as? NSDictionary {
                    print("Api response \(res)")
                }
            }, errorState: { (error) in
                print("ERROR FETCH API \(String(describing: error))")
            })
    }


}

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
