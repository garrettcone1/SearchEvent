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
    
    func getRequestToken(_ completionHandler: @escaping (_ success: Bool, _ requestToken: String?, _ errorString: String?) -> Void) {
        
        
    }
}
