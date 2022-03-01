//
//  Address.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 26/02/22.
//

import Foundation

struct Address: Codable {
    var bairro: String
    var cep: String
    var complemento: String
    var ddd: String
    var gia: String?
    var ibge: String?
    var localidade: String
    var logradouro: String
    var siafi: String?
    var uf: String
}
