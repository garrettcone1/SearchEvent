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
        
        static let authorizationURL = "https://www.eventbrite.com/oauth/authorize"
        static let accessTokenURL = "https://www.eventbrite.com/oauth/token"
        
        static let APIScheme = "https"
        static let APIHost = "www.eventbrite.com"
        static let APIPath = "/oauth/authorize"
    }
    
    struct Methods {
        
        static let eventsSearch = "/events/search/"
    }
    
    struct EBParameterKeys {
        
        static let APIKey = "client_id"
    }
    
    struct EBParameterValues {
        
        static let APIKey = "VGFH4P6MBCK6LDYHLB"
    }
}
