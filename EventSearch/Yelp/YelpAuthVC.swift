//
//  YelpAuthVC.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class YelpAuthVC: UIViewController, WKUIDelegate {
    
    //@IBOutlet weak var webView: WKWebView!
    var webView: WKWebView!
    var urlRequest: URLRequest? = nil
    var completionHandler: ((_ success: Bool, _ errorString: String?) -> Void)? = nil
    
    
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadView()
        
        navigationItem.title = "EventBrite Auth"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(pressedCancel))
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let myURL = URL(string: YelpClient.Constants.Yelp.authenticateURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    @objc func pressedCancel() {
        
        dismiss(animated: true, completion: nil)
    }
    
}
