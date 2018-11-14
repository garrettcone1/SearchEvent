//
//  EventBriteAuthVC.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class EventBriteAuthVC: UIViewController, WKUIDelegate {
    
    //@IBOutlet weak var webView: WKWebView!
    var webView: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "EventBrite Auth"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(pressedCancel))
        
        let myURL = URL(string: EventBriteClient.Constants.authorizationURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    @objc func pressedCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
}
