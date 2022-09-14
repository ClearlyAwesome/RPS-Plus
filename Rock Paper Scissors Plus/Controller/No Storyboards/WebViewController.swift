//
//  ViewController.swift
//  webview test
//
//  Created by R C on 12/7/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var webAddress = global.webString
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: webAddress)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}


