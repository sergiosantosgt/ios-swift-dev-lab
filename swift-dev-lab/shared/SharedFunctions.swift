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
}
