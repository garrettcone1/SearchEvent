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
}
