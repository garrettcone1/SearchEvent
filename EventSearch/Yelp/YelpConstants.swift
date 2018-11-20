//
//  YelpConstants.swift
//  EventSearch
//
//  Created by Garrett Cone on 11/14/18.
//  Copyright © 2018 Garrett Cone. All rights reserved.
//

import Foundation
import UIKit

extension YelpClient {
    
    struct Constants {
        
        // Authorization URL
        static let authorizationURL = "https://api.yelp.com/v3"
        static let APIScheme = "https"
        static let APIHost = "www.eventbrite.com"
        static let APIPath = "/oauth"
        
        static let authenticateURL = "https://www.eventbriteapi.com/v3/users/me/?token="
        
    }
    
    struct Methods {
        
        
    }
    
    struct YelpParameterKeys {
        
        static let APIKey = "api_key"
        
    }
    
    struct YelpParameterValues {
        
        static let clientID = "AY2bfS9v9dNsHxist6eRbg"
        static let APIKey = "Wor9XUTNP8575bilH5jYoVWKw6VOSkQkoB4F0WrDduW0qoEEB4lNTN58airVQz8IQN7v7p5hSZ2h8w8EmMgYfWoLnJ6nEgPknhcHIqkcq4-ZC0nFB4qUl9g4MJ_zW3Yx"
        
    }
}
