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
    
    public func getEventsForPin(pin: Pin) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let coreDataStack = appDelegate.coreDataStack
        
        performuUIUpdatesOnMain {
            YelpClient.sharedInstance().taskForGETMethod(latitude: pin.latitude, longitude: pin.longitude) { (success, data, error) in
                
                if let data = data {
                    
                    for item in data {
                        
                        let eventURL = item[Constants.YelpResponseKeys.events] as! String
                        
                        let event = Event(eventData: nil, eventURL: eventURL, context: coreDataStack.context)
                        
                        pin.addToEvents(event)
                        
                        coreDataStack.save()
                    }
                }
                
                pin.isDownloaded = true
            }
        }
    }
    
    func authenticateWithViewController(viewController: UIViewController, completionHandlerForLogin: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        
        let authorizationURL = URL(string: "\(Constants.Yelp.authenticateURL)")
        let request = URLRequest(url: authorizationURL!)
        let webViewController = viewController.storyboard!.instantiateViewController(withIdentifier: "YelpAuthVC") as! YelpAuthVC
        
        webViewController.urlRequest = request
        webViewController.completionHandler = completionHandlerForLogin
        
        let webAuthNavigationController = UINavigationController()
        webAuthNavigationController.pushViewController(webViewController, animated: false)
        
        performuUIUpdatesOnMain {
            viewController.present(webAuthNavigationController, animated: true, completion: nil)
        }
    }
    
}
