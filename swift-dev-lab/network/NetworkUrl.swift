//
//  NetworkUrl.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 01/03/22.
//

import Foundation

class NetworkUrl {
    enum Endpoints: String {
        private var baseURL: String { return "https://www.purchase.com" }

        case product = "/product"
        case user = "/user"
        case store = "/store"
        case payment = "/payment"
        
        var url: URL {
            guard let url = URL(string: baseURL) else {
                preconditionFailure("The url used in \(Endpoints.self) is not valid")
            }
            return url.appendingPathComponent(self.rawValue)
        }
    }
    
    public func getAddressUrlByZipCode(zipCode: String) -> String {
        return "https://viacep.com.br/ws/\(zipCode)/json/"
    }
}
