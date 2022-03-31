//
//  WebViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Roberto dos Santos Junior on 16/03/22.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    @IBOutlet weak var webViewBox: UIView!
    
    var webView: WKWebView!
    var internalUrl: String = ""
    let urlWebView: String = "https://apple.com"
    
    let redirect: String = "Você será redirecionado para fora do Aplicativo. Deseja continuar?"
    let confirm: String = "OK"
    let cancel: String = "Cancelar"
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        loadWebView()
        setWebView()
    }
    
    func loadWebView() {
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewBox.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewBox.addSubview(webView)
        setConstraints()
    }
    
    func setConstraints() {
        webView.topAnchor.constraint(equalTo: webViewBox.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewBox.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewBox.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewBox.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewBox.heightAnchor).isActive = true
        webView.uiDelegate = self
    }
    
    func setWebView() {
        let url = URL(string: urlWebView)
        let request = URLRequest(url: url!)
        webView.frame = view.bounds
        webView.navigationDelegate = self
        webView.load(request)
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    func loadWebPage(request: URLRequest)  {
        var newRequest = request
        newRequest.addValue(String(Date().currentTimeMillis()/1000/60), forHTTPHeaderField: "loaded")
        webView!.load(newRequest)
    }
    
    func presentNavigationAlert(msg: String, navigationUrl: URL){
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            UIApplication.shared.open((navigationUrl))
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getAppleLogoHref(webView: WKWebView) {
        self.webView.evaluateJavaScript("(function() { return (document.getElementById('ac-gn-firstfocus-small').href); })();") { (value, error) in
            
            print("Value \(String(describing: value))")
            
            if value != nil {
                let valueString: String = value as! String
                let replacedValue = valueString.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "null", with: "").replacingOccurrences(of: "Optional()", with: "")
                
                print("replacedValue: \(String(describing: replacedValue))")
            }
        }
    }
    
    func overrideAppleBarColor(webView: WKWebView) {
        let el = "javascript:(function() { " +
            "var headerBar = document.getElementById('ac-globalnav');"
            + "headerBar.style.backgroundColor = 'red';" +
        "})()"

        webView.evaluateJavaScript(el, completionHandler: { (html, error) in
            if error != nil {
                print("Error: \(String(describing: error))")
            }
        })
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if let url = navigationAction.request.url {
            
            let destinationURL = navigationAction.request.url?.absoluteString
            
            let sharedFunctions = SharedFunctions()
            let runWebView = sharedFunctions.runWebView(destinationURL: destinationURL!)

            if (runWebView) {
                internalUrl = destinationURL!
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "showWebView", sender: nil)
                }
            } else {
                
                let alert = UIAlertController(title: nil, message: redirect, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: confirm, style: UIAlertAction.Style.default, handler: { action in
                    UIApplication.shared.open(url)
                    self.loadWebView()
                    self.setWebView()
                }))
                alert.addAction(UIAlertAction(title: cancel, style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } else {
            print("Not executed!")
        }
        
        var webViewC: WKWebView!
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewBox.frame.size.height))
        webViewC = WKWebView (frame: customFrame , configuration: configuration)
        webViewC.translatesAutoresizingMaskIntoConstraints = false
        self.webViewBox.addSubview(webViewC)
        
        return webViewC
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("WebView URL: \(String(describing: webView.url))")
        let url: URL = webView.url!
        if url.absoluteString.contains("apple.com") {
            print("Apple Web View")
            self.getAppleLogoHref(webView: webView)
            self.overrideAppleBarColor(webView: webView)
        } else {
            print("Other Web View")
        }
    }
}

/*extension WebViewController {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy)
        -> Void) {
        
        let blank: String = "about:blank"
        let destination = navigationAction.request.url?.absoluteString ?? blank
        
        if navigationAction.request.httpMethod != "GET" ||
            navigationAction.request.value(forHTTPHeaderField: "loaded") != nil ||
            destination.contains(blank) {
            decisionHandler(.allow)
            return
        }
        
        
        if (destination.contains("apple.com")) {
            print("Inside \(destination)")
            decisionHandler(.cancel)
            loadWebPage(request: navigationAction.request)
        } else {
            print("Outside \(destination)")
            decisionHandler(.cancel)
            let navigationUrl = navigationAction.request.url!
            self.presentNavigationAlert(msg: self.redirect, navigationUrl: navigationUrl)
        }
    }
}*/

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
