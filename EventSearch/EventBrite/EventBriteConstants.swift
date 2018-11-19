//
//  EventBriteConstants.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

extension EventBriteClient {
    
    struct Constants {
        
        // Authorization URL
        static let authorizationURL = "https://www.eventbrite.com/oauth/authorize"
        static let APIScheme = "https"
        static let APIHost = "www.eventbrite.com"
        static let APIPath = "/oauth"
        
        // Request Token URL
        static let requestTokenURL = "https://www.eventbrite.com/oauth/token"
        
        static let authenticateURL = "https://www.eventbriteapi.com/v3/users/me/?token="
        
    }
    
    struct Methods {
        
        static let eventsSearch = "/events/search/"
        static let tokenMethod = "/token"
        static let APIMethod = "/authorize"
        
    }
    
    struct EBParameterKeys {
        
        static let APIKey = "client_id"
        static let responseType = "respone_type"
    }
    
    struct EBParameterValues {
        
        static let APIKey = "VGFH4P6MBCK6LDYHLB"
        static let code = "code"
    }
}
