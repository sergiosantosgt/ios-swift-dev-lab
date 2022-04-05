//
//  FilmService.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 03/03/22.
//

import Foundation
import Alamofire

class FilmService {
    func fetchFilms(completion: @escaping (_ response: Films) -> Void) {
        let request = AF.request("https://swapi.dev/api/films")
        request.responseDecodable(of: Films.self) { (response) in
            guard let ret = response.value else { return }
            completion(ret)
        }
    }
}
