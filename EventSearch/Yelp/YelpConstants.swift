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
        
        struct Yelp {
            
            // Authorization URL
            static let authorizationURL = "https://api.yelp.com/v3"
            static let APIScheme = "https://"
            static let APIHost = "api.yelp.com"
            static let APIPath = "/v3"
            static let EventsEndpoint = "/events"
        }
    
        struct Methods {
        
            static let events = "/events"
        }
    
        struct YelpParameterKeys {
        
            static let APIKey = "api_key"
        
            static let limit = "limit"
            static let latitute = "latitude"
            static let longitude = "longitude"
            static let radius = "radius"
        
        }
    
        struct YelpParameterValues {
        
            static let clientID = "AY2bfS9v9dNsHxist6eRbg"
            static let APIKey = "Wor9XUTNP8575bilH5jYoVWKw6VOSkQkoB4F0WrDduW0qoEEB4lNTN58airVQz8IQN7v7p5hSZ2h8w8EmMgYfWoLnJ6nEgPknhcHIqkcq4-ZC0nFB4qUl9g4MJ_zW3Yx"
            static let radiusValue = 24000
        }
    
        struct YelpResponseKeys {
        
            static let total = "total"
            static let events = "events"
            static let image = "image_url"
            static let latitude = "latitude"
            static let longitude = "longitude"
            static let name = "name"
            static let date = "time_start"
        }
    }
}
