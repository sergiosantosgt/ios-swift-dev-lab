//
//  Films.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 03/03/22.
//

import Foundation


struct Films: Decodable {
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
