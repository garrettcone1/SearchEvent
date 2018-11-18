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
        static let APIPath = "/oauth/authorize"
        
        // Request Token URL
        static let requestTokenURL = "https://www.eventbrite.com/oauth/token"
        static let tokenScheme = "https"
        static let tokenHost = "www.eventbrite.com"
        static let tokenPath = "/oauth/token"
    }
    
    struct Methods {
        
        static let eventsSearch = "/events/search/"
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
