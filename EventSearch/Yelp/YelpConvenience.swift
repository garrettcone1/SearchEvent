//
//  YelpConvenience.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

extension YelpClient {
    
    func authenticateWithViewController(_ viewController: UIViewController, completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        // THIS IS A TEST TO SEE IF I AM CORRECTLY LOADING THE WEBVIEW WITH THE RIGHT REQUEST
        authorizationURL() { (success, errorString) in
            
            if success {
                
                completionHandlerForAuth(success, nil)
            } else {
                
                print("Error with loading webview")
            }
        }
    }
    
    func authorizationURL(/*latitude: Double, longitude: Double,*/_ completionHandler: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        /*let parameters = [
            Constants.YelpParameterKeys.APIKey: Constants.YelpParameterValues.APIKey
        ]*/
        
        let _ = taskForGETMethod(latitude: Constants.YelpParameterKeys.latitute, longitude: Constants.YelpParameterKeys.longitude) { (success, results, error)  in
            
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
        
        let authorizationURL = URL(string: "\(Constants.Yelp.authenticateURL)\(requestToken!)")
        let request = URLRequest(url: authorizationURL!)
        let webViewController = viewController.storyboard!.instantiateViewController(withIdentifier: "YelpAuthVC") as! YelpAuthVC
        
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
