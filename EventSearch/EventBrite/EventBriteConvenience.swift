//
//  EventBriteConvenience.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

extension EventBriteClient {
    
    // Create authentication request with this URL: https://www.eventbrite.com/oauth/authorize?response_type=token&client_id=YOUR_CLIENT_KEY
    
    func authenticateWithViewController(_ viewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        
    }
    
    func authorizationURL(_ completionHandler: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let parameters = [
            EBParameterKeys.responseType: EBParameterValues.code,
            EBParameterKeys.APIKey: EBParameterValues.APIKey
        ]
        
        let _ = taskForGETMethod(EventBriteClient.Methods.APIMethod, parameters: parameters as [String: AnyObject]) { (results, error) in
            
            if let error = error {
                print(error)
                completionHandler(false, "Could not reach Authorization URL")
            } else {
                
                
            }
        }
    }
    
    func getRequestToken(_ completionHandler: @escaping (_ success: Bool, _ requestToken: String?, _ errorString: String?) -> Void) {
        
        
    }
    
    func loginWithToken(_ requestToken: String?, viewController: UIViewController, completionHandlerForLogin: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let authorizationURL = URL(string: "\(Constants.authenticateURL)\(requestToken!)")
        let request = URLRequest(url: authorizationURL!)
        let webViewController = viewController.storyboard!.instantiateViewController(withIdentifier: "EventBriteAuthVC") as! EventBriteAuthVC
        
        webViewController.urlRequest = request
        webViewController.requestToken = requestToken
        webViewController.completionHandler = completionHandlerForLogin
        
        let webAuthNavigationController = UINavigationController()
        webAuthNavigationController.pushViewController(webViewController, animated: false)
        
        performuUIUpdatesOnMain {
            viewController.present(webAuthNavigationController, animated: true, completion: nil)
        }
    }
    
}
