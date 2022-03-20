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
    let urlWebView: String = "https://google.com"
    
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
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if let url = navigationAction.request.url{
            
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
            print("Open it locally")
        }
        
        var webViewC: WKWebView!
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewBox.frame.size.height))
        webViewC = WKWebView (frame: customFrame , configuration: configuration)
        webViewC.translatesAutoresizingMaskIntoConstraints = false
        self.webViewBox.addSubview(webViewC)
        
        return webViewC
    }
}
