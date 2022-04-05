//
//  SharedFunctions.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 16/03/22.
//

import Foundation

class SharedFunctions {
    func runWebView(destinationURL: String) -> Bool {
        var runWebView = false
        
        /*for urlWebView in service { // TODO
            if(urlWebView.validationType == "startsWith" && destinationURL.starts(with: urlWebView.url)) {
                runWebView = true
                break
            } else if (urlWebView.validationType == "contains" && (destinationURL).contains(urlWebView.url) ) {
                runWebView = true
                break
            }
        }*/
        
        if(destinationURL.starts(with: "https://www.google.com")) {
            runWebView = true
        } else if(destinationURL.contains("https://www.google.com")) {
            runWebView = true
        }
        
        return runWebView
    }
    
    func replaceBackSlash(value: String) -> String {
        return value.replacingOccurrences(of: "\\", with: "\\\\")
    }
    
    func readJSONFromFile(fileName: String) -> Any? {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                print("Error on read file!")
            }
        }
        return json
    }
}
